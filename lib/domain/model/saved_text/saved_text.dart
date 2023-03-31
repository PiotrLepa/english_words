import 'package:english_words/domain/model/ipa_transcription/ipa_transcription.dart';
import 'package:english_words/domain/model/translations/translations.dart';
import 'package:english_words/domain/model/word_definitions/word_definitions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_text.freezed.dart';

@freezed
class SavedText with _$SavedText {
  const factory SavedText({
    String? id,
    required String originalText,
    required Translations translations,
    required IpaTranscription ipaTranscription,
    List<WordDefinitions>? definitions,
    required String sourceLanguage,
    required String targetLanguage,
    required bool isLearned,
    required DateTime creationDate,
  }) = _SavedText;
}
