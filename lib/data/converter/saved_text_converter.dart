import 'package:cloud_firestore/cloud_firestore.dart';
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
        translations: _translationConverter.toDomain(response.translations),
        ipaTranscription:
            _ipaTranscriptionConverter.toDomain(response.ipaTranscription),
        sourceLanguage: response.sourceLanguage,
        targetLanguage: response.targetLanguage,
        isLearned: response.isLearned,
        creationDate: response.creationDate.toDate(),
      );

  SavedTextResponse toData(SavedText body) => SavedTextResponse(
        id: body.id,
        originalText: body.originalText,
        translations: _translationConverter.toData(body.translations),
        ipaTranscription:
            _ipaTranscriptionConverter.toData(body.ipaTranscription),
        sourceLanguage: body.sourceLanguage,
        targetLanguage: body.targetLanguage,
        isLearned: body.isLearned,
        creationDate: Timestamp.fromDate(body.creationDate),
      );
}
