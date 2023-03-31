import 'package:english_words/domain/model/word_definitions/word_definitions.dart';
import 'package:english_words/domain/use_case/get_word_definitions_use_case.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTextDefinitionsUseCase {
  static final RegExp _splitPattern = RegExp(r'[ \. ,]+');
  final GetWordDefinitionsUseCase _getWordDefinitionsUseCase;

  GetTextDefinitionsUseCase(this._getWordDefinitionsUseCase);

  Future<List<WordDefinitions>> invoke(String text) {
    final wordsDefinitions = text
        .split(_splitPattern)
        .map((word) => _getWordDefinitionsUseCase.invoke(word));
    return Future.wait(wordsDefinitions);
  }
}
