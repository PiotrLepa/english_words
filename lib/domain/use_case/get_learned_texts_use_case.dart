import 'package:english_words/domain/model/saved_text/saved_text.dart';
import 'package:english_words/domain/repository/saved_texts_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetLearnedTextsUseCase {
  final SavedTextRepository _repository;

  GetLearnedTextsUseCase(this._repository);

  Future<List<SavedText>> invoke() =>
      _repository.getLearnedTexts();
}
