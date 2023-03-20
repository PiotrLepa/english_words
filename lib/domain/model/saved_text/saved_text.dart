import 'package:english_words/domain/model/ipa_transcription/ipa_transcription.dart';
import 'package:english_words/domain/model/translation/translation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_text.freezed.dart';

@freezed
class SavedText with _$SavedText {
  const factory SavedText({
    String? id,
    required String originalText,
    required List<Translation> translations,
    required IpaTranscription ipaTranscription,
    required bool isLearned,
    required DateTime creationDate,
  }) = _SavedText;
}
