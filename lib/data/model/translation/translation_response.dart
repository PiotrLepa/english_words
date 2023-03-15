// ignore: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'translation_response.freezed.dart';

part 'translation_response.g.dart';

@freezed
class TranslationResponse with _$TranslationResponse {
  const factory TranslationResponse({
    @JsonKey(name: 'detected_source_language')
        required String detectedSourceLanguage,
    required String text,
  }) = _TranslationResponse;

  factory TranslationResponse.fromJson(Map<String, dynamic> json) =>
      _$TranslationResponseFromJson(json);
}
