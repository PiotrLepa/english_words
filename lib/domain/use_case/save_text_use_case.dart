import 'package:english_words/domain/model/saved_text/saved_text.dart';
import 'package:english_words/domain/repository/saved_texts_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SaveTextUseCase {
  final SavedTextRepository _repository;

  SaveTextUseCase(this._repository);

  Future<void> invoke(SavedText text) =>
      _repository.saveText(text);
}
