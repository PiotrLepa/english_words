import 'package:english_words/data/model/translation/general/translations_response.dart';
import 'package:english_words/domain/model/translations/translations.dart';
import 'package:injectable/injectable.dart';

@injectable
class TranslationConverter {
  Translations toDomain(TranslationsResponse response) => Translations(
        translations: response.translations,
      );

  TranslationsResponse toData(Translations response) => TranslationsResponse(
        translations: response.translations,
      );
}
