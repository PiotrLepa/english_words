import 'package:english_words/domain/repository/translation_repository.dart';
import 'package:english_words/domain/model/translation/translation.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTranslationUseCase {
  final TranslationRepository _repository;

  GetTranslationUseCase(this._repository);

  Future<List<Translation>> invoke(String text) =>
      _repository.getTranslations(text);
}
