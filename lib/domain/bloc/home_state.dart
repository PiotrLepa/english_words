part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState.initial() => const HomeState(
        savedTexts: [],
        isTranslatingInProgress: false,
      );

  const factory HomeState({
    required List<TextInfo> savedTexts,
    required bool isTranslatingInProgress,
  }) = _HomeState;
}
