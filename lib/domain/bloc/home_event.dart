part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.screenStarted() = ScreenStarted;

  const factory HomeEvent.textSubmitted(String text) = TextSubmitted;

  const factory HomeEvent.savedTextDeleted(SavedText item) =
      SavedTextDeletedEvent;

  const factory HomeEvent.undoSavedTextDeletion() =
      UndoSavedTextDeletion;
}
