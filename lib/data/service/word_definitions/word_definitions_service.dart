import 'package:english_words/data/model/word_definitions/word_definitions_response.dart';

abstract class WordDefinitionsService {
  Future<WordDefinitionsResponse> getWordDefinitions(String word);
}
