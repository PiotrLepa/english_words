import 'package:freezed_annotation/freezed_annotation.dart';

part 'translation_response.freezed.dart';

part 'translation_response.g.dart';

@freezed
class TranslationResponse with _$TranslationResponse {

  static const _detectedSourceLanguageOtherName = 'detected_source_language';

  const factory TranslationResponse({
    required String detectedSourceLanguage,
    required String text,
  }) = _TranslationResponse;

  factory TranslationResponse.fromJson(Map<String, dynamic> json) =>
      _$TranslationResponseFromJson(_adjustParameterName(json));

  static Map<String, dynamic> _adjustParameterName(Map<String, dynamic> json) {
    if (!json.containsKey(_detectedSourceLanguageOtherName)) return json;
    return {
        ...json,
        'detectedSourceLanguage': json['detected_source_language'],
      };
  }
}
