import 'package:english_words/data/converter/word_ipa_transcription_converter.dart';
import 'package:english_words/data/model/ipa_transcription/ipa_transcription_response.dart';
import 'package:english_words/domain/model/ipa_transcription/ipa_transcription.dart';
import 'package:injectable/injectable.dart';

@injectable
class IpaTranscriptionConverter {
  final IpaWordTranscriptionConverter _wordConverter;

  IpaTranscriptionConverter(this._wordConverter);

  IpaTranscription toDomain(IpaTranscriptionResponse response) =>
      IpaTranscription(
        dialect: response.dialect,
        words: response.words.map(_wordConverter.toDomain).toList(),
      );

  IpaTranscriptionResponse toData(IpaTranscription response) =>
      IpaTranscriptionResponse(
        dialect: response.dialect,
        words: response.words.map(_wordConverter.toData).toList(),
      );
}
