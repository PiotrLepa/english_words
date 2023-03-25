import 'dart:developer';

import 'package:english_words/domain/model/modified_text/modified_text.dart';
import 'package:english_words/domain/model/saved_text/saved_text.dart';
import 'package:english_words/domain/use_case/delete_saved_text_use_case.dart';
import 'package:english_words/domain/use_case/get_learned_texts_use_case.dart';
import 'package:english_words/domain/use_case/save_text_use_case.dart';
import 'package:english_words/domain/use_case/update_saved_text_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'learned_texts_bloc.freezed.dart';

part 'learned_texts_event.dart';

part 'learned_texts_state.dart';

@injectable
class LearnedTextsBloc extends Bloc<LearnedTextsEvent, LearnedTextsState> {
  final GetLearnedTextsUseCase _getLearnedTextsUseCase;
  final SaveTextUseCase _saveTextUseCase;
  final UpdateSavedTextUseCase _updateSavedTextUseCase;
  final DeleteSavedTextUseCase _deleteSavedTextUseCase;

  ModifiedText? _lastDeletedText;
  ModifiedText? _lastTextMovedToLearn;

  LearnedTextsBloc(
    this._getLearnedTextsUseCase,
    this._saveTextUseCase,
    this._updateSavedTextUseCase,
    this._deleteSavedTextUseCase,
  ) : super(const LearnedTextsState(
          status: LearnedTextsStatus.initialLoading,
          learnedTexts: [],
        )) {
    on<ScreenStarted>(_onScreenStarted);
    on<TextMovedToLearn>(_onTextMovedToLearn);
    on<UndoMovingTextToLearn>(_onUndoMovingTextToLearn);
    on<TextDeleted>(_onTextDeleted);
    on<UndoDeletingText>(_onUndoDeletingText);
  }

  Future<void> _onScreenStarted(
    ScreenStarted event,
    Emitter<LearnedTextsState> emit,
  ) async {
    await _getLearnedTextsUseCase.invoke().then((learnedTexts) {
      emit(state.copyWith(
        status: LearnedTextsStatus.initiallyLoaded,
        learnedTexts: learnedTexts,
      ));
    }).catchError((error, stackTrace) {
      emit(state.copyWith(
        status: LearnedTextsStatus.initialFailure,
      ));
      log(
        'getting learned texts failed',
        error: error,
        stackTrace: stackTrace,
      );
    });
  }

  Future<void> _onTextMovedToLearn(
    TextMovedToLearn event,
    Emitter<LearnedTextsState> emit,
  ) async {
    _lastTextMovedToLearn = ModifiedText(
      index: state.learnedTexts.indexOf(event.item),
      text: event.item,
    );

    emit(state.copyWith(
      status: LearnedTextsStatus.textMovedToLearn,
      learnedTexts: state.learnedTexts.toList()..remove(event.item),
    ));

    final updatedText = event.item.copyWith(isLearned: false);
    _updateSavedTextUseCase
        .invoke(updatedText)
        .catchError((error, stackTrace) {
      log(
        'updating saved text failed',
        error: error,
        stackTrace: stackTrace,
      );
    });
  }

  Future<void> _onUndoMovingTextToLearn(
    UndoMovingTextToLearn event,
    Emitter<LearnedTextsState> emit,
  ) async {
    final textMovedToLearn = _lastTextMovedToLearn;
    if (textMovedToLearn == null) return;

    emit(state.copyWith(
      status: LearnedTextsStatus.undoMovingTextToLearn,
      learnedTexts: state.learnedTexts.toList()
        ..insert(textMovedToLearn.index, textMovedToLearn.text),
    ));

    final updatedText = textMovedToLearn.text.copyWith(isLearned: true);
    _lastTextMovedToLearn = null;

    _updateSavedTextUseCase
        .invoke(updatedText)
        .catchError((error, stackTrace) {
      log(
        'undo adding text to learned failed',
        error: error,
        stackTrace: stackTrace,
      );
    });
  }

  Future<void> _onTextDeleted(
    TextDeleted event,
    Emitter<LearnedTextsState> emit,
  ) async {
    _lastDeletedText = ModifiedText(
      index: state.learnedTexts.indexOf(event.item),
      text: event.item,
    );

    emit(state.copyWith(
      status: LearnedTextsStatus.textDeleted,
      learnedTexts: state.learnedTexts.toList()..remove(event.item),
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

  Future<void> _onUndoDeletingText(
    UndoDeletingText event,
    Emitter<LearnedTextsState> emit,
  ) async {
    final deletedText = _lastDeletedText;
    if (deletedText == null) return;

    emit(state.copyWith(
      status: LearnedTextsStatus.undoTextDeletion,
      learnedTexts: state.learnedTexts.toList()
        ..insert(deletedText.index, deletedText.text),
    ));

    _lastDeletedText = null;

    _saveTextUseCase
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
