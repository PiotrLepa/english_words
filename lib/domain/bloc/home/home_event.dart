part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.screenStarted() = ScreenStarted;

  const factory HomeEvent.textSubmitted(String text) = TextSubmitted;

  const factory HomeEvent.textAddedToLearned(SavedText item) =
      TextAddedToLearned;

  const factory HomeEvent.undoAddingTextToLearned() = UndoAddingTextToLearned;

  const factory HomeEvent.savedTextDeleted(SavedText item) = SavedTextDeleted;

  const factory HomeEvent.undoDeletingSavedText() = UndoDeletingSavedText;

  const factory HomeEvent.translationEdited(
    SavedText item,
    String? newTranslation,
  ) = TranslationEdited;
}
