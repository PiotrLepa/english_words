import 'package:english_words/domain/model/saved_text/saved_text.dart';
import 'package:english_words/domain/repository/saved_texts_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateSavedTextUseCase {
  final SavedTextRepository _repository;

  UpdateSavedTextUseCase(this._repository);

  Future<SavedText> invoke(SavedText text) => _repository.update(text);
}
