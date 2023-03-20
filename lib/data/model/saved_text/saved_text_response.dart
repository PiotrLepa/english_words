import 'package:english_words/data/model/ipa_transcription/ipa_transcription_response.dart';
import 'package:english_words/data/model/translation/translation_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_text_response.freezed.dart';

part 'saved_text_response.g.dart';

@freezed
class SavedTextResponse with _$SavedTextResponse {
  @JsonSerializable(explicitToJson: true)
  const factory SavedTextResponse({
    required String originalText,
    required List<TranslationResponse> translations,
    required IpaTranscriptionResponse ipaTranscription,
    required bool isLearned,
  }) = _SavedTextResponse;

  factory SavedTextResponse.fromJson(Map<String, dynamic> json) =>
      _$SavedTextResponseFromJson(json);
}