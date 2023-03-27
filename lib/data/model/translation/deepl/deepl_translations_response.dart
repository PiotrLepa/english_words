import 'package:english_words/data/model/translation/deepl/deepl_translation_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'deepl_translations_response.freezed.dart';

part 'deepl_translations_response.g.dart';

@freezed
class DeeplTranslationsResponse with _$DeeplTranslationsResponse {
  const factory DeeplTranslationsResponse({
    required List<DeeplTranslationResponse> translations,
  }) = _DeeplTranslationsResponse;

  factory DeeplTranslationsResponse.fromJson(Map<String, dynamic> json) =>
      _$DeeplTranslationsResponseFromJson(json);
}
