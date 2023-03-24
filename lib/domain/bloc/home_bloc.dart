import 'dart:developer';

import 'package:english_words/domain/model/modified_text/modified_text.dart';
import 'package:english_words/domain/model/saved_text/saved_text.dart';
import 'package:english_words/domain/use_case/delete_saved_text_use_case.dart';
import 'package:english_words/domain/use_case/get_info_and_save_text_use_case.dart';
import 'package:english_words/domain/use_case/get_texts_to_learn_use_case.dart';
import 'package:english_words/domain/use_case/save_text_use_case.dart';
import 'package:english_words/domain/use_case/update_saved_text_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'home_bloc.freezed.dart';

part 'home_event.dart';

part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetTextsToLearnUseCase _getTextsToLearnUseCase;
  final GetInfoAndSaveTextUseCase _getInfoAndSaveTextUseCase;
  final SaveTextUseCase _saveTextUseCase;
  final UpdateSavedTextUseCase _updateSavedTextUseCase;
  final DeleteSavedTextUseCase _deleteSavedTextUseCase;

  ModifiedText? _lastDeletedText;
  ModifiedText? _lastLearnedText;

  HomeBloc(
    this._getTextsToLearnUseCase,
    this._getInfoAndSaveTextUseCase,
    this._saveTextUseCase,
    this._updateSavedTextUseCase,
    this._deleteSavedTextUseCase,
  ) : super(const HomeState(
          status: HomeStatus.initialLoading,
          savedTexts: [],
        )) {
    on<ScreenStarted>(_onScreenStarted);
    on<TextSubmitted>(_onTextSubmitted);
    on<TextAddedToLearned>(_onTextAddedToLearned);
    on<UndoAddingTextToLearned>(_onUndoAddingTextToLearned);
    on<SavedTextDeleted>(_onSavedTextDeleted);
    on<UndoDeletingSavedText>(_onUndoDeletingSavedText);
  }

  Future<void> _onScreenStarted(
    ScreenStarted event,
    Emitter<HomeState> emit,
  ) async {
    await _getTextsToLearnUseCase.invoke().then((savedTexts) {
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

  Future<void> _onTextAddedToLearned(
    TextAddedToLearned event,
    Emitter<HomeState> emit,
  ) async {
    _lastLearnedText = ModifiedText(
      index: state.savedTexts.indexOf(event.item),
      text: event.item,
    );

    emit(state.copyWith(
      status: HomeStatus.savedTextLearned,
      savedTexts:
          state.savedTexts.where((text) => text.id != event.item.id).toList(),
    ));

    final updatedText = event.item.copyWith(isLearned: true);
    await _updateSavedTextUseCase
        .invoke(updatedText)
        .catchError((error, stackTrace) {
      log(
        'updating saved text failed',
        error: error,
        stackTrace: stackTrace,
      );
    });
  }

  Future<void> _onUndoAddingTextToLearned(
    UndoAddingTextToLearned event,
    Emitter<HomeState> emit,
  ) async {
    final learnedText = _lastLearnedText;
    if (learnedText == null) return;

    emit(state.copyWith(
      status: HomeStatus.undoAddingTextToLearned,
      savedTexts: state.savedTexts.toList()
        ..insert(learnedText.index, learnedText.text),
    ));

    final updatedText = learnedText.text.copyWith(isLearned: false);
    _lastLearnedText = null;

    await _updateSavedTextUseCase
        .invoke(updatedText)
        .catchError((error, stackTrace) {
      log(
        'undo adding text to learned failed',
        error: error,
        stackTrace: stackTrace,
      );
    });
  }

  Future<void> _onSavedTextDeleted(
    SavedTextDeleted event,
    Emitter<HomeState> emit,
  ) async {
    _lastDeletedText = ModifiedText(
      index: state.savedTexts.indexOf(event.item),
      text: event.item,
    );

    emit(state.copyWith(
      status: HomeStatus.savedTextDeleted,
      savedTexts:
          state.savedTexts.where((text) => text.id != event.item.id).toList(),
    ));

    await _deleteSavedTextUseCase
        .invoke(event.item.id!)
        .catchError((error, stackTrace) {
      log(
        'deleting saved text failed',
        error: error,
        stackTrace: stackTrace,
      );
    });
  }

  Future<void> _onUndoDeletingSavedText(
    UndoDeletingSavedText event,
    Emitter<HomeState> emit,
  ) async {
    final deletedText = _lastDeletedText;
    if (deletedText == null) return;

    emit(state.copyWith(
      status: HomeStatus.undoSavedTextDeletion,
      savedTexts: state.savedTexts.toList()
        ..insert(deletedText.index, deletedText.text),
    ));

    _lastDeletedText = null;

    await _saveTextUseCase
        .invoke(deletedText.text)
        .catchError((error, stackTrace) {
      log(
        'restoring deleted saved text failed',
        error: error,
        stackTrace: stackTrace,
      );
    });
  }
}
