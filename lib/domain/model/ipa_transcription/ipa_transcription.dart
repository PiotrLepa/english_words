import 'package:english_words/domain/model/word_ipa_transcription/word_ipa_transcription.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ipa_transcription.freezed.dart';

@freezed
class IpaTranscription with _$IpaTranscription {
  const factory IpaTranscription({
    required String dialect,
    required List<WordIpaTranscription> words,
  }) = _IpaTranscription;
}
