import 'package:english_words/data/model/word_definitions/word_definition_response.dart';
import 'package:english_words/domain/model/word_definitions/word_definition.dart';
import 'package:injectable/injectable.dart';

@injectable
class WordDefinitionConverter {
  WordDefinition toDomain(WordDefinitionResponse response) => WordDefinition(
        definition: response.definition,
        partOfSpeech: response.partOfSpeech,
        synonyms: response.synonyms,
        antonyms: response.antonyms,
        derivation: response.derivation,
        examples: response.examples,
      );

  WordDefinitionResponse toData(WordDefinition body) => WordDefinitionResponse(
        definition: body.definition,
        partOfSpeech: body.partOfSpeech,
        synonyms: body.synonyms,
        antonyms: body.antonyms,
        derivation: body.derivation,
        examples: body.examples,
      );
}
