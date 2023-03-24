import 'dart:developer';

import 'package:english_words/domain/model/saved_text/saved_text.dart';
import 'package:english_words/domain/use_case/delete_saved_text_use_case.dart';
import 'package:english_words/domain/use_case/get_info_and_save_text_use_case.dart';
import 'package:english_words/domain/use_case/get_saved_texts_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'home_bloc.freezed.dart';

part 'home_event.dart';

part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetSavedTextsUseCase _getSavedTextsUseCase;
  final GetInfoAndSaveTextUseCase _getInfoAndSaveTextUseCase;
  final DeleteSavedTextUseCase _deleteSavedTextUseCase;

  SavedText? _recentlyDeletedText;
  int? _recentlyDeletedTextIndex;

  HomeBloc(
    this._getSavedTextsUseCase,
    this._getInfoAndSaveTextUseCase,
    this._deleteSavedTextUseCase,
  ) : super(const HomeState(
          status: HomeStatus.initialLoading,
          savedTexts: [],
        )) {
    on<ScreenStarted>(_onScreenStarted);
    on<TextSubmitted>(_onTextSubmitted);
    on<SavedTextDeleted>(_onSavedTextDeleted);
    on<UndoSavedTextDeletion>(_onUndoSavedTextDeletion);
  }

  Future<void> _onScreenStarted(
    ScreenStarted event,
    Emitter<HomeState> emit,
  ) async {
    await _getSavedTextsUseCase.invoke().then((savedTexts) {
      emit(state.copyWith(
        status: HomeStatus.initiallyLoaded,
        savedTexts: savedTexts,
      ));
    }).catchError((error, stackTrace) {
      emit(state.copyWith(
        status: HomeStatus.initialFailure,
      ));
      log(
        'getting saved texts failed',
        error: error,
        stackTrace: stackTrace,
      );
    });
  }

  Future<void> _onTextSubmitted(
    TextSubmitted event,
    Emitter<HomeState> emit,
  ) async {
    final trimmedText = event.text.trim();
    if (trimmedText.isEmpty ||
        state.status == HomeStatus.translationInProgress) {
      return;
    }

    emit(state.copyWith(
      status: HomeStatus.translationInProgress,
    ));

    if (_isTextAlreadySaved(trimmedText)) {
      emit(state.copyWith(
        status: HomeStatus.textAlreadySaved,
      ));
      return;
    }

    await _getInfoAndSaveTextUseCase.invoke(trimmedText).then((textInfo) {
      emit(state.copyWith(
        status: HomeStatus.translationSuccessful,
        savedTexts: [textInfo, ...state.savedTexts],
      ));
    }).catchError((error, stackTrace) {
      emit(state.copyWith(
        status: HomeStatus.translationFailure,
      ));
      log(
        'getting text info and saving failed',
        error: error,
        stackTrace: stackTrace,
      );
    });
  }

  bool _isTextAlreadySaved(String text) =>
      state.savedTexts.any((element) => element.originalText == text);

  Future<void> _onSavedTextDeleted(
    SavedTextDeleted event,
    Emitter<HomeState> emit,
  ) async {
    _recentlyDeletedText = event.item;
    _recentlyDeletedTextIndex = state.savedTexts.indexOf(event.item);

    await _deleteSavedTextUseCase
        .invoke(event.item.id!)
        .catchError((error, stackTrace) {
      log(
        'deleting saved text failed',
        error: error,
        stackTrace: stackTrace,
      );
    }).whenComplete(() {
      emit(state.copyWith(
        status: HomeStatus.savedTextDeleted,
      ));
    });
  }

  Future<void> _onUndoSavedTextDeletion(
    UndoSavedTextDeletion event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(
      status: HomeStatus.undoSavedTextDeletion,
      savedTexts: state.savedTexts.toList()
        ..insert(_recentlyDeletedTextIndex!, _recentlyDeletedText!),
    ));

    _recentlyDeletedText = null;
    _recentlyDeletedTextIndex = null;
  }
}
