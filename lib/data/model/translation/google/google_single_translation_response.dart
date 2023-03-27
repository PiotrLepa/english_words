import 'package:english_words/data/model/translation/deepl/deepl_translation_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'google_single_translation_response.freezed.dart';

part 'google_single_translation_response.g.dart';

@freezed
class GoogleSingleTranslationResponse with _$GoogleSingleTranslationResponse {
  const factory GoogleSingleTranslationResponse({
    required String translatedText,
  }) = _GoogleSingleTranslationResponse;

  factory GoogleSingleTranslationResponse.fromJson(Map<String, dynamic> json) =>
      _$GoogleSingleTranslationResponseFromJson(json);
}
