import 'package:freezed_annotation/freezed_annotation.dart';

part 'deepl_translation_response.freezed.dart';

part 'deepl_translation_response.g.dart';

@freezed
class DeeplTranslationResponse with _$DeeplTranslationResponse {
  const factory DeeplTranslationResponse({
    @JsonKey(name: 'detected_source_language')
        required String detectedSourceLanguage,
    required String text,
  }) = _DeeplTranslationResponse;

  factory DeeplTranslationResponse.fromJson(Map<String, dynamic> json) =>
      _$DeeplTranslationResponseFromJson(json);
}
