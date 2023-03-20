import 'package:english_words/data/converter/translation_converter.dart';
import 'package:english_words/domain/repository/translation_repository.dart';
import 'package:english_words/data/service/translation/translation_service.dart';
import 'package:english_words/domain/model/translation/translation.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TranslationRepository)
class TranslationRepositoryImpl extends TranslationRepository {
  final TranslationService _service;
  final TranslationConverter _translationConverter;

  TranslationRepositoryImpl(
    this._service,
    this._translationConverter,
  );

  @override
  Future<List<Translation>> getTranslations(String text) => _service
      .translate(text)
      .then((list) => list.map(_translationConverter.toDomain).toList());
}
