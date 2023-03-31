import 'package:english_words/domain/model/word_definitions/word_definitions.dart';

abstract class WordDefinitionsDefinitionRepository {
  Future<WordDefinitions> getWordDefinitions(String word);
}
