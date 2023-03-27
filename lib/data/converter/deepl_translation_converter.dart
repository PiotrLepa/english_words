import 'package:english_words/data/model/translation/deepl/deepl_translations_response.dart';
import 'package:english_words/data/model/translation/general/translations_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeeplTranslationConverter {
  TranslationsResponse toData(DeeplTranslationsResponse response) =>
      TranslationsResponse(
        translations: response.translations.map((e) => e.text).toList(),
      );
}
