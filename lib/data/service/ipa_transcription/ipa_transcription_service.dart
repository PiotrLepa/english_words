import 'package:english_words/data/model/ipa_transcription/ipa_transcription_response.dart';

abstract class IpaTranscriptionService {
  Future<IpaTranscriptionResponse> getIpaTranscription(String text);
}
