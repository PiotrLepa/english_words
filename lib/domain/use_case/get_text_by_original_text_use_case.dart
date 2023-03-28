import 'package:english_words/domain/model/saved_text/saved_text.dart';
import 'package:english_words/domain/repository/saved_texts_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTextByOriginalTextUseCase {
  final SavedTextRepository _repository;

  GetTextByOriginalTextUseCase(this._repository);

  Future<SavedText?> invoke(String originalText) =>
      _repository.getByOriginalText(originalText.trim());
}
