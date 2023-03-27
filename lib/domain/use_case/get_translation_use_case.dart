import 'package:english_words/domain/model/translations/translations.dart';
import 'package:english_words/domain/repository/translation_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTranslationUseCase {
  final TranslationRepository _repository;

  GetTranslationUseCase(this._repository);

  Future<Translations> invoke(String text) =>
      _repository.getTranslations(text);
}
