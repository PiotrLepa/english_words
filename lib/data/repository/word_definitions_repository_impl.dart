import 'package:english_words/data/converter/word_definitions_converter.dart';
import 'package:english_words/data/service/word_definitions/word_definitions_service.dart';
import 'package:english_words/domain/model/word_definitions/word_definitions.dart';
import 'package:english_words/domain/repository/word_definitions_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: WordDefinitionsDefinitionRepository)
class WordDefinitionsRepositoryImpl
    extends WordDefinitionsDefinitionRepository {
  final WordDefinitionsService _service;
  final WordDefinitionsConverter _wordsDefinitionsConverter;

  WordDefinitionsRepositoryImpl(this._service,
      this._wordsDefinitionsConverter,);

  @override
  Future<WordDefinitions> getWordDefinitions(String word) =>
      _service.getWordDefinitions(word).then(
          _wordsDefinitionsConverter.toDomain);
}
