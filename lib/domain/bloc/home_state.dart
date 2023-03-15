part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState.initial() => const HomeState(
        savedTexts: null,
      );

  const factory HomeState({List<TextInfo>? savedTexts}) = _HomeState;
}
