import 'package:english_words/data/model/translation/general/translations_response.dart';

abstract class TranslationService {
  Future<TranslationsResponse> translate(String text);
}
