import 'package:english_words/data/converter/ipa_transcription_converter.dart';
import 'package:english_words/data/converter/translation_converter.dart';
import 'package:english_words/data/model/saved_text/saved_text_response.dart';
import 'package:english_words/domain/model/saved_text/saved_text.dart';
import 'package:injectable/injectable.dart';

@injectable
class SavedTextConverter {
  final IpaTranscriptionConverter _ipaTranscriptionConverter;
  final TranslationConverter _translationConverter;

  SavedTextConverter(
    this._translationConverter,
    this._ipaTranscriptionConverter,
  );

  SavedText toDomain(SavedTextResponse response) => SavedText(
        id: response.id,
        originalText: response.originalText,
        translations:
            response.translations.map(_translationConverter.toDomain).toList(),
        ipaTranscription:
            _ipaTranscriptionConverter.toDomain(response.ipaTranscription),
        isLearned: response.isLearned,
      );

  SavedTextResponse toData(SavedText body) => SavedTextResponse(
        id: body.id,
        originalText: body.originalText,
        translations:
            body.translations.map(_translationConverter.toData).toList(),
        ipaTranscription:
            _ipaTranscriptionConverter.toData(body.ipaTranscription),
        isLearned: body.isLearned,
      );
}
