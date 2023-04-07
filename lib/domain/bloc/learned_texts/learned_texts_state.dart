part of 'learned_texts_bloc.dart';

enum LearnedTextsStatus {
  initialLoading,
  initiallyLoaded,
  initialFailure,
  textMovedToLearn,
  undoMovingTextToLearn,
  textDeleted,
  undoTextDeletion,
  translationUpdated,
  translationInProgress,
  translationSuccessful,
  translationFailure,
  textAlreadyLearned,
  textAlreadySaved,
  selectedTextTranslated,
}

@freezed
class LearnedTextsState with _$LearnedTextsState {
  const factory LearnedTextsState({
    required LearnedTextsStatus status,
    required List<SavedText> learnedTexts,
    SavedText? translatedSelectedText,
  }) = _LearnedTextsState;
}
