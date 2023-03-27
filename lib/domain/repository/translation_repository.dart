import 'package:english_words/domain/model/translations/translations.dart';

abstract class TranslationRepository {
  Future<Translations> getTranslations(String text);
}
