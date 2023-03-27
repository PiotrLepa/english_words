import 'package:english_words/data/model/translation/google/google_single_translation_response.dart';
import 'package:english_words/data/model/translation/google/google_translations_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'google_translations_wrapper_response.freezed.dart';

part 'google_translations_wrapper_response.g.dart';

@freezed
class GoogleTranslationsWrapperResponse
    with _$GoogleTranslationsWrapperResponse {
  const factory GoogleTranslationsWrapperResponse({
    required GoogleTranslationsResponse data,
  }) = _GoogleTranslationsWrapperResponse;

  factory GoogleTranslationsWrapperResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GoogleTranslationsWrapperResponseFromJson(json);
}
