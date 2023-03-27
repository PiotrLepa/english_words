import 'package:english_words/data/model/translation/deepl/deepl_translation_response.dart';
import 'package:english_words/data/model/translation/google/google_single_translation_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'google_translations_response.freezed.dart';

part 'google_translations_response.g.dart';

@freezed
class GoogleTranslationsResponse with _$GoogleTranslationsResponse {
  const factory GoogleTranslationsResponse({
    required List<GoogleSingleTranslationResponse> translations,
  }) = _GoogleTranslationsResponse;

  factory GoogleTranslationsResponse.fromJson(Map<String, dynamic> json) =>
      _$GoogleTranslationsResponseFromJson(json);
}
