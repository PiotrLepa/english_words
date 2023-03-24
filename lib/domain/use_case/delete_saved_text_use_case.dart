import 'package:english_words/domain/repository/saved_texts_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteSavedTextUseCase {
  final SavedTextRepository _repository;

  DeleteSavedTextUseCase(this._repository);

  Future<void> invoke(String id) => _repository.delete(id);
}
