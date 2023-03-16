part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.loading({
    required List<TextInfo> savedTexts,
    required bool isTranslatingInProgress,
  }) = Loading;

  const factory HomeState.translationSuccessful({
    required List<TextInfo> savedTexts,
    required bool isTranslatingInProgress,
  }) = TranslationSuccessful;

  const factory HomeState.translationFailure({
    required List<TextInfo> savedTexts,
    required bool isTranslatingInProgress,
  }) = TranslationFailure;
}
