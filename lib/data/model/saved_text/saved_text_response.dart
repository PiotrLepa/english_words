import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_words/data/json/firebase_timestamp_json_converter.dart';
import 'package:english_words/data/model/ipa_transcription/ipa_transcription_response.dart';
import 'package:english_words/data/model/translation/general/translations_response.dart';
import 'package:english_words/data/model/word_definitions/word_definitions_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_text_response.freezed.dart';

part 'saved_text_response.g.dart';

@freezed
class SavedTextResponse with _$SavedTextResponse {
  @JsonSerializable(explicitToJson: true)
  const factory SavedTextResponse({
    @JsonKey(includeToJson: false) String? id,
    required String originalText,
    required TranslationsResponse translations,
    required IpaTranscriptionResponse ipaTranscription,
    WordDefinitionsResponse? definitions,
    required String sourceLanguage,
    required String targetLanguage,
    required bool isLearned,
    @FirebaseTimestampJsonConverter() required Timestamp creationDate,
  }) = _SavedTextResponse;

  factory SavedTextResponse.fromJson(Map<String, dynamic> json) =>
      _$SavedTextResponseFromJson(json);

  factory SavedTextResponse.fromJsonFirestore({
    required String id,
    required Map<String, dynamic> json,
  }) =>
      SavedTextResponse.fromJson({...json, 'id': id});
}
