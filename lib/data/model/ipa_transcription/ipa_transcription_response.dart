import 'package:freezed_annotation/freezed_annotation.dart';

part 'ipa_transcription_response.freezed.dart';

part 'ipa_transcription_response.g.dart';

@freezed
class IpaTranscriptionResponse with _$IpaTranscriptionResponse {
  const factory IpaTranscriptionResponse({
    required String dialect,
    required String text,
  }) = _IpaTranscriptionResponse;

  factory IpaTranscriptionResponse.fromJson(Map<String, dynamic> json) =>
      _$IpaTranscriptionResponseFromJson(json);
}
