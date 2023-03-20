import 'dart:developer';

import 'package:english_words/domain/model/text_info/saved_text.dart';
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

  SavedText? _recentlyDeletedText;
  int? _recentlyDeletedTextIndex;

  HomeBloc(
    this._getSavedTextsUseCase,
    this._getInfoAndSaveTextUseCase,
  ) : super(const HomeState.initialLoading(
          savedTexts: [],
          isTranslatingInProgress: false,
        )) {
    on<ScreenStarted>(_onScreenStarted);
    on<TextSubmitted>(_onTextSubmitted);
    on<SavedTextDeletedEvent>(_onSavedTextDeleted);
    on<UndoSavedTextDeletion>(_onUndoSavedTextDeletion);
  }

  Future<void> _onScreenStarted(
    ScreenStarted event,
    Emitter<HomeState> emit,
  ) async {
    await _getSavedTextsUseCase.invoke().then((savedTexts) {
      emit(HomeState.initiallyLoaded(
        isTranslatingInProgress: false,
        savedTexts: savedTexts,
      ));
    }).catchError((error, stackTrace) {
      emit(HomeState.translationFailure(
        // TODO create new state?
        isTranslatingInProgress: false,
        savedTexts: state.savedTexts,
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
    if (trimmedText.isEmpty || state.isTranslatingInProgress) return;
    if (_isTextAlreadySaved(trimmedText)) {
      emit(HomeState.textAlreadySaved(
        isTranslatingInProgress: false,
        savedTexts: state.savedTexts,
      ));
      return;
    }

    emit(HomeState.initiallyLoaded( // TODO new state?
      isTranslatingInProgress: true,
      savedTexts: state.savedTexts,
    ));
    await _getInfoAndSaveTextUseCase.invoke(trimmedText).then((textInfo) {
      emit(HomeState.translationSuccessful(
        isTranslatingInProgress: false,
        savedTexts: [textInfo, ...state.savedTexts],
      ));
    }).catchError((error, stackTrace) {
      emit(HomeState.translationFailure(
        isTranslatingInProgress: false,
        savedTexts: state.savedTexts,
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
    SavedTextDeletedEvent event,
    Emitter<HomeState> emit,
  ) async {
    _recentlyDeletedText = event.item;
    _recentlyDeletedTextIndex = state.savedTexts.indexOf(event.item);

    emit(HomeState.savedTextDeleted(
      isTranslatingInProgress: false,
      savedTexts:
          state.savedTexts.where((element) => element != event.item).toList(),
    ));
  }

  Future<void> _onUndoSavedTextDeletion(
    UndoSavedTextDeletion event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeState.initiallyLoaded( // TODO new state?
      isTranslatingInProgress: false,
      savedTexts: state.savedTexts.toList()
        ..insert(_recentlyDeletedTextIndex!, _recentlyDeletedText!),
    ));
    _recentlyDeletedText = null;
    _recentlyDeletedTextIndex = null;
  }
}
