import 'package:english_words/domain/model/ipa_transcription/ipa_transcription.dart';
import 'package:english_words/domain/model/saved_text/saved_text.dart';
import 'package:english_words/domain/model/translations/translations.dart';
import 'package:english_words/domain/use_case/get_ipa_transcription_use_case.dart';
import 'package:english_words/domain/use_case/get_translation_use_case.dart';
import 'package:english_words/domain/use_case/save_text_use_case.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetInfoAndSaveTextUseCase {
  final GetTranslationUseCase _getTranslationUseCase;
  final GetIpaTranscriptionUseCase _getIpaTranscriptionUseCase;
  final SaveTextUseCase _saveTextUseCase;

  GetInfoAndSaveTextUseCase(
    this._getTranslationUseCase,
    this._getIpaTranscriptionUseCase,
    this._saveTextUseCase,
  );

  Future<SavedText> invoke(String text) => Future.wait([
        _getTranslationUseCase.invoke(text),
        _getIpaTranscriptionUseCase.invoke(text),
      ]).then((data) {
        final translations = data[0] as Translations;
        final ipaTranscription = data[1] as IpaTranscription;
        return SavedText(
          id: null,
          originalText: text,
          translations: translations,
          ipaTranscription: ipaTranscription,
          sourceLanguage: 'en',
          targetLanguage: 'pl',
          isLearned: false,
          creationDate: DateTime.now(),
        );
      }).then(_saveTextUseCase.invoke);
}
