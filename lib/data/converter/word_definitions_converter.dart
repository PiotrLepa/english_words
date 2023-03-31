import 'package:english_words/data/converter/word_definition_converter.dart';
import 'package:english_words/data/model/word_definitions/word_definitions_response.dart';
import 'package:english_words/domain/model/word_definitions/word_definitions.dart';
import 'package:injectable/injectable.dart';

@injectable
class WordDefinitionsConverter {
  final WordDefinitionConverter _wordDefinitionConverter;

  WordDefinitionsConverter(this._wordDefinitionConverter);

  WordDefinitions toDomain(WordDefinitionsResponse response) => WordDefinitions(
        word: response.word,
        results: response.results.map(_wordDefinitionConverter.toDomain).toList(),
      );

  WordDefinitionsResponse toData(WordDefinitions body) => WordDefinitionsResponse(
        word: body.word,
        results: body.results.map(_wordDefinitionConverter.toData).toList(),
      );
}
