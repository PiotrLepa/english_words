import 'package:english_words/data/model/word_ipa_transcription/word_ipa_transcription_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ipa_transcription_response.freezed.dart';

part 'ipa_transcription_response.g.dart';

@freezed
class IpaTranscriptionResponse with _$IpaTranscriptionResponse {
  @JsonSerializable(explicitToJson: true)
  const factory IpaTranscriptionResponse({
    required String dialect,
    required List<WordIpaTranscriptionResponse> words,
  }) = _IpaTranscriptionResponse;

  factory IpaTranscriptionResponse.fromJson(Map<String, dynamic> json) =>
      _$IpaTranscriptionResponseFromJson(json);
}
