import 'package:english_words/data/model/translation/deepl/deepl_translation_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'translations_response.freezed.dart';

part 'translations_response.g.dart';

@freezed
class TranslationsResponse with _$TranslationsResponse {
  const factory TranslationsResponse({
    required List<String> translations,
  }) = _TranslationsResponse;

  factory TranslationsResponse.fromJson(Map<String, dynamic> json) =>
      _$TranslationsResponseFromJson(json);
}
