import 'package:english_words/data/model/translation/general/translations_response.dart';
import 'package:english_words/data/model/translation/google/google_translations_wrapper_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class GoogleTranslationConverter {
  TranslationsResponse toData(GoogleTranslationsWrapperResponse response) =>
      TranslationsResponse(
        translations:
            response.data.translations.map((e) => e.translatedText).toList(),
      );
}
