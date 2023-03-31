import 'package:english_words/domain/model/word_definitions/word_definitions.dart';
import 'package:english_words/domain/repository/word_definitions_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetWordDefinitionsUseCase {
  final WordDefinitionsDefinitionRepository _repository;

  GetWordDefinitionsUseCase(this._repository);

  Future<WordDefinitions> invoke(String word) =>
      _repository.getWordDefinitions(word);
}
