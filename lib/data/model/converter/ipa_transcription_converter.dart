import 'package:english_words/data/model/ipa_transcription/ipa_transcription_response.dart';
import 'package:english_words/domain/model/ipa_transcription/ipa_transcription.dart';
import 'package:injectable/injectable.dart';

@injectable
class IpaTranscriptionConverter {
  IpaTranscription toDomain(IpaTranscriptionResponse response) =>
      IpaTranscription(
        dialect: response.dialect,
        text: response.text,
      );
}
