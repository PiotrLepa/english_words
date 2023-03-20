import 'package:english_words/domain/model/text_info/saved_text.dart';
import 'package:english_words/domain/repository/saved_texts_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSavedTextsUseCase {
  final SavedTextRepository _repository;

  GetSavedTextsUseCase(this._repository);

  Future<List<SavedText>> invoke() =>
      _repository.getSavedTexts();
}
