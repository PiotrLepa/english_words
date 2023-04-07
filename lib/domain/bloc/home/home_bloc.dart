import 'dart:developer';

import 'package:english_words/domain/model/modified_text/modified_text.dart';
import 'package:english_words/domain/model/saved_text/saved_text.dart';
import 'package:english_words/domain/use_case/delete_saved_text_use_case.dart';
import 'package:english_words/domain/use_case/get_info_and_save_text_use_case.dart';
import 'package:english_words/domain/use_case/get_text_by_original_text_use_case.dart';
import 'package:english_words/domain/use_case/get_text_info_use_case.dart';
import 'package:english_words/domain/use_case/get_texts_to_learn_use_case.dart';
import 'package:english_words/domain/use_case/save_text_use_case.dart';
import 'package:english_words/domain/use_case/update_saved_text_use_case.dart';
import 'package:english_words/domain/use_case/update_translation_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'home_bloc.freezed.dart';

part 'home_event.dart';

part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetTextByOriginalTextUseCase _getTextByOriginalTextUseCase;
  final GetTextsToLearnUseCase _getTextsToLearnUseCase;
  final GetTextInfoUseCase _getTextInfoUseCase;
  final GetInfoAndSaveTextUseCase _getInfoAndSaveTextUseCase;
  final SaveTextUseCase _saveTextUseCase;
  final UpdateSavedTextUseCase _updateSavedTextUseCase;
  final DeleteSavedTextUseCase _deleteSavedTextUseCase;
  final UpdateTranslationUseCase _updateTranslationUseCase;

  ModifiedText? _lastDeletedText;
  ModifiedText? _lastLearnedText;

  HomeBloc(
    this._getTextByOriginalTextUseCase,
    this._getTextsToLearnUseCase,
    this._getTextInfoUseCase,
    this._getInfoAndSaveTextUseCase,
    this._saveTextUseCase,
    this._updateSavedTextUseCase,
    this._deleteSavedTextUseCase,
    this._updateTranslationUseCase,
  ) : super(const HomeState(
          status: HomeStatus.initialLoading,
          textsToLearn: [],
        )) {
    on<ScreenStarted>(_onScreenStarted);
    on<TextSubmitted>(_onTextSubmitted);
    on<TextAddedToLearned>(_onTextAddedToLearned);
    on<UndoAddingTextToLearned>(_onUndoAddingTextToLearned);
    on<SavedTextDeleted>(_onSavedTextDeleted);
    on<UndoDeletingSavedText>(_onUndoDeletingSavedText);
    on<TranslationEdited>(_onTranslationEdited);
    on<TranslateClicked>(_onTranslateClicked);
    on<TranslateAndSaveClicked>(_onTranslateAndSaveClicked);
    on<PopupWithTranslatedTextClosed>(_onPopupWithTranslatedTextClosed);
  }

  Future<void> _onScreenStarted(
    ScreenStarted event,
    Emitter<HomeState> emit,
  ) async {
    await _getTextsToLearnUseCase.invoke().then((textsToLearn) {
      emit(state.copyWith(
        status: HomeStatus.initiallyLoaded,
        textsToLearn: textsToLearn,
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
    await _getAndSaveTextInfoIfValid(event.text, emit);
  }

  Future<SavedText?> _getAndSaveTextInfoIfValid(
    String text,
    Emitter<HomeState> emit,
  ) async {
    if (text.isEmpty || state.status == HomeStatus.translationInProgress) {
      return Future.value(null);
    }

    emit(state.copyWith(
      status: HomeStatus.translationInProgress,
    ));

    final savedText = await _getTextByOriginalTextUseCase.invoke(text);
    if (savedText != null) {
      if (savedText.isLearned) {
        emit(state.copyWith(
          status: HomeStatus.textAlreadyLearned,
        ));
      } else {
        emit(state.copyWith(
          status: HomeStatus.textAlreadySaved,
        ));
      }
      return Future.value(null);
    }

    try {
      final textInfo = await _getInfoAndSaveTextUseCase.invoke(text);
      emit(state.copyWith(
        status: HomeStatus.translationSuccessful,
        textsToLearn: [textInfo, ...state.textsToLearn],
      ));
      return Future.value(textInfo);
    } catch (error, stackTrace) {
      emit(state.copyWith(
        status: HomeStatus.translationFailure,
      ));
      log(
        'getting text info and saving failed',
        error: error,
        stackTrace: stackTrace,
      );
      return Future.value(null);
    }
  }

  Future<void> _onTextAddedToLearned(
    TextAddedToLearned event,
    Emitter<HomeState> emit,
  ) async {
    _lastLearnedText = ModifiedText(
      index: state.textsToLearn.indexOf(event.item),
      text: event.item,
    );

    emit(state.copyWith(
      status: HomeStatus.savedTextLearned,
      textsToLearn: state.textsToLearn.toList()..remove(event.item),
    ));

    final updatedText = event.item.copyWith(isLearned: true);
    _updateSavedTextUseCase.invoke(updatedText).catchError((error, stackTrace) {
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
      textsToLearn: state.textsToLearn.toList()
        ..insert(learnedText.index, learnedText.text),
    ));

    final updatedText = learnedText.text.copyWith(isLearned: false);
    _lastLearnedText = null;

    _updateSavedTextUseCase.invoke(updatedText).catchError((error, stackTrace) {
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
      index: state.textsToLearn.indexOf(event.item),
      text: event.item,
    );

    emit(state.copyWith(
      status: HomeStatus.savedTextDeleted,
      textsToLearn: state.textsToLearn.toList()..remove(event.item),
    ));

    _deleteSavedTextUseCase
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
      textsToLearn: state.textsToLearn.toList()
        ..insert(deletedText.index, deletedText.text),
    ));

    _lastDeletedText = null;

    _saveTextUseCase.invoke(deletedText.text).catchError((error, stackTrace) {
      log(
        'restoring deleted saved text failed',
        error: error,
        stackTrace: stackTrace,
      );
    });
  }

  Future<void> _onTranslationEdited(
    TranslationEdited event,
    Emitter<HomeState> emit,
  ) async {
    if (event.newTranslation == null) return;

    final updatedItem = _updateTranslationUseCase.invoke(
      event.item,
      event.newTranslation!,
    );

    final indexToUpdate = state.textsToLearn.indexOf(event.item);
    emit(state.copyWith(
      status: HomeStatus.translationUpdated,
      textsToLearn: state.textsToLearn.toList()
        ..remove(event.item)
        ..insert(indexToUpdate, updatedItem),
    ));

    await _updateSavedTextUseCase
        .invoke(updatedItem)
        .catchError((error, stackTrace) {
      log(
        'failed to update translation',
        error: error,
        stackTrace: stackTrace,
      );
    });
  }

  Future<void> _onTranslateClicked(
    TranslateClicked event,
    Emitter<HomeState> emit,
  ) async {
    if (event.text.isEmpty ||
        state.status == HomeStatus.translationInProgress) {
      return Future.value(null);
    }

    emit(state.copyWith(
      status: HomeStatus.translationInProgress,
    ));

    await _getTextInfoUseCase.invoke(event.text).then((textInfo) {
      emit(state.copyWith(
        status: HomeStatus.selectedTextTranslated,
        translatedSelectedText: textInfo,
      ));
    }).catchError((error, stackTrace) {
      emit(state.copyWith(
        status: HomeStatus.selectedTextTranslated,
      ));
      log(
        'getting text info and saving failed',
        error: error,
        stackTrace: stackTrace,
      );
    });
  }

  Future<void> _onTranslateAndSaveClicked(
    TranslateAndSaveClicked event,
    Emitter<HomeState> emit,
  ) async {
    await _getAndSaveTextInfoIfValid(event.text, emit).then((textInfo) {
      emit(state.copyWith(
        status: HomeStatus.selectedTextTranslated,
        translatedSelectedText: textInfo,
      ));
    });
  }

  Future<void> _onPopupWithTranslatedTextClosed(
    PopupWithTranslatedTextClosed event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(
      translatedSelectedText: null,
    ));
  }
}
