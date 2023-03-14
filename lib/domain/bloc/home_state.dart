part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState.initial() => const HomeState(
        savedWords: null,
      );

  const factory HomeState({List<String>? savedWords}) = _HomeState;
}
