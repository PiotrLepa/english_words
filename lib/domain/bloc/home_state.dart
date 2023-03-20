part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initialLoading({
    required List<SavedText> savedTexts,
    required bool isTranslatingInProgress,
  }) = InitialLoading;

  const factory HomeState.initiallyLoaded({
    required List<SavedText> savedTexts,
    required bool isTranslatingInProgress,
  }) = InitiallyLoaded;

  const factory HomeState.translationSuccessful({
    required List<SavedText> savedTexts,
    required bool isTranslatingInProgress,
  }) = TranslationSuccessful;

  const factory HomeState.textAlreadySaved({
    required List<SavedText> savedTexts,
    required bool isTranslatingInProgress,
  }) = TextAlreadySaved;

  const factory HomeState.translationFailure({
    required List<SavedText> savedTexts,
    required bool isTranslatingInProgress,
  }) = TranslationFailure;

  const factory HomeState.savedTextDeleted({
    required List<SavedText> savedTexts,
    required bool isTranslatingInProgress,
  }) = SavedTextDeleted;
}
