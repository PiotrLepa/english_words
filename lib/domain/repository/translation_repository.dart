import 'package:english_words/domain/model/translation/translation.dart';

abstract class TranslationRepository {
  Future<List<Translation>> getTranslations(String text);
}
