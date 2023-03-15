part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState.initial() => const HomeState(
        savedTexts: [],
      );

  const factory HomeState({
    required List<TextInfo> savedTexts,
  }) = _HomeState;
}
