import 'package:english_words/domain/model/ipa_transcription/ipa_transcription.dart';
import 'package:english_words/domain/model/saved_text/saved_text.dart';
import 'package:english_words/domain/model/translations/translations.dart';
import 'package:english_words/domain/model/word_definitions/word_definitions.dart';
import 'package:english_words/domain/use_case/get_ipa_transcription_use_case.dart';
import 'package:english_words/domain/use_case/get_translation_use_case.dart';
import 'package:english_words/domain/use_case/get_word_definitions_use_case.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTextInfoUseCase {
  final GetTranslationUseCase _getTranslationUseCase;
  final GetIpaTranscriptionUseCase _getIpaTranscriptionUseCase;
  final GetWordDefinitionsUseCase _getTextDefinitionsUseCase;

  GetTextInfoUseCase(
    this._getTranslationUseCase,
    this._getIpaTranscriptionUseCase,
    this._getTextDefinitionsUseCase,
  );

  Future<SavedText> invoke(String text) {
    return Future.wait([
      _getTranslationUseCase.invoke(text),
      _getIpaTranscriptionUseCase.invoke(text),
      _getTextDefinitionsOrNull(text),
    ]).then((data) {
      final translations = data[0] as Translations;
      final ipaTranscription = data[1] as IpaTranscription;
      final definitions = tryCast<WordDefinitions>(data[2]);
      return SavedText(
        id: null,
        originalText: text,
        translations: translations,
        ipaTranscription: ipaTranscription,
        definitions: definitions,
        sourceLanguage: 'en',
        targetLanguage: 'pl',
        isLearned: false,
        creationDate: DateTime.now(),
      );
    });
  }

  Future<WordDefinitions?> _getTextDefinitionsOrNull(String text) async {
    try {
      return await _getTextDefinitionsUseCase.invoke(text);
    } catch (e) {
      return Future.value(null);
    }
  }

  T? tryCast<T>(x) => x is T ? x : null;
}
