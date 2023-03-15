import 'package:english_words/domain/model/ipa_transcription/ipa_transcription.dart';
import 'package:english_words/domain/model/text_info/text_info.dart';
import 'package:english_words/domain/model/translation/translation.dart';
import 'package:english_words/domain/repository/ipa_transcription_repository.dart';
import 'package:english_words/domain/use_case/get_ipa_transcription_use_case.dart';
import 'package:english_words/domain/use_case/get_translation_use_case.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTextInfoUseCase {
  final GetTranslationUseCase _getTranslationUseCase;
  final GetIpaTranscriptionUseCase _getIpaTranscriptionUseCase;

  GetTextInfoUseCase(
    this._getTranslationUseCase,
    this._getIpaTranscriptionUseCase,
  );

  Future<TextInfo> invoke(String text) => Future.wait([
        _getTranslationUseCase.invoke(text),
        _getIpaTranscriptionUseCase.invoke(text),
      ]).then((data) {
        final translations = data[0] as List<Translation>;
        final ipaTranscription = data[1] as IpaTranscription;
        return TextInfo(
          originalText: text,
          translations: translations,
          ipaTranscription: ipaTranscription,
        );
      });
}
