part of 'home_bloc.dart';

enum HomeStatus {
  initialLoading,
  initiallyLoaded,
  initialFailure,
  translationInProgress,
  translationSuccessful,
  translationFailure,
  textAlreadySaved,
  textAlreadyLearned,
  savedTextLearned,
  undoAddingTextToLearned,
  savedTextDeleted,
  undoSavedTextDeletion,
  translationUpdated,
  selectedTextTranslated,
}

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required HomeStatus status,
    required List<SavedText> textsToLearn,
    SavedText? translatedSelectedText,
  }) = _HomeState;
}
