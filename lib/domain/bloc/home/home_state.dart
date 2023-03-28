part of 'home_bloc.dart';

enum HomeStatus {
  initialLoading,
  initiallyLoaded,
  initialFailure,
  translationInProgress,
  translationSuccessful,
  translationFailure,
  textAlreadySaved,
  savedTextLearned,
  undoAddingTextToLearned,
  savedTextDeleted,
  undoSavedTextDeletion,
  translationUpdated,
}

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required HomeStatus status,
    required List<SavedText> textsToLearn,
  }) = _HomeState;
}
