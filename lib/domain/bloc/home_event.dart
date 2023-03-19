part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.textSubmitted(String text) = TextSubmitted;

  const factory HomeEvent.savedTextDeleted(TextInfo item) = SavedTextDeletedEvent;
}
