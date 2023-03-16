import 'package:freezed_annotation/freezed_annotation.dart';

part 'word_ipa_transcription_response.freezed.dart';

part 'word_ipa_transcription_response.g.dart';

@freezed
class WordIpaTranscriptionResponse with _$WordIpaTranscriptionResponse {
  const factory WordIpaTranscriptionResponse({
    required bool isSuccessfull,
    required String text,
  }) = _WordIpaTranscriptionResponse;

  factory WordIpaTranscriptionResponse.fromJson(Map<String, dynamic> json) =>
      _$WordIpaTranscriptionResponseFromJson(json);
}
