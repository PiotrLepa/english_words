import 'package:english_words/domain/model/ipa_transcription/ipa_transcription.dart';

abstract class IpaTranscriptionRepository {
  Future<IpaTranscription> getIpaTranscription(String text);
}
