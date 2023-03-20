import 'package:english_words/data/model/ipa_transcription/ipa_transcription_response.dart';
import 'package:english_words/data/model/word_ipa_transcription/word_ipa_transcription_response.dart';
import 'package:english_words/domain/model/ipa_transcription/ipa_transcription.dart';
import 'package:english_words/domain/model/word_ipa_transcription/word_ipa_transcription.dart';
import 'package:injectable/injectable.dart';

@injectable
class IpaWordTranscriptionConverter {
  WordIpaTranscription toDomain(WordIpaTranscriptionResponse response) =>
      WordIpaTranscription(
        isSuccessful: response.isSuccessful,
        text: response.text,
      );

  WordIpaTranscriptionResponse toData(WordIpaTranscription body) =>
      WordIpaTranscriptionResponse(
        isSuccessful: body.isSuccessful,
        text: body.text,
      );
}
