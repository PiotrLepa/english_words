import 'package:english_words/data/model/translation/translation_response.dart';

abstract class TranslationService {
  Future<List<TranslationResponse>> translate(String text);
}
