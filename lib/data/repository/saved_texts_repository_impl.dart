import 'package:english_words/data/converter/saved_text_converter.dart';
import 'package:english_words/data/service/firestore/firestore_texts_service.dart';
import 'package:english_words/domain/model/saved_text/saved_text.dart';
import 'package:english_words/domain/repository/saved_texts_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SavedTextRepository)
class SavedTextRepositoryImpl extends SavedTextRepository {
  final FirestoreTextsService _service;
  final SavedTextConverter _converter;

  SavedTextRepositoryImpl(
    this._service,
    this._converter,
  );

  @override
  Future<SavedText?> getByOriginalText(String originalText) =>
      _service.getByOriginalText(originalText).then((response) {
        if (response != null) {
          return _converter.toDomain(response);
        }
      });

  @override
  Future<List<SavedText>> getTextsToLearn() => _service
      .getTextsToLearn()
      .then((list) => list.map(_converter.toDomain).toList());

  @override
  Future<List<SavedText>> getLearnedTexts() => _service
      .getLearnedTexts()
      .then((list) => list.map(_converter.toDomain).toList());

  @override
  Future<SavedText> save(SavedText text) =>
      _service.save(_converter.toData(text)).then(_converter.toDomain);

  @override
  Future<SavedText> update(SavedText text) =>
      _service.update(_converter.toData(text)).then(_converter.toDomain);

  @override
  Future<void> delete(String id) => _service.delete(id);
}
