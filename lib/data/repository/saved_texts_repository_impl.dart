import 'package:english_words/data/converter/saved_text_converter.dart';
import 'package:english_words/data/service/firestore/firestore_service.dart';
import 'package:english_words/domain/model/text_info/saved_text.dart';
import 'package:english_words/domain/repository/saved_texts_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SavedTextRepository)
class SavedTextRepositoryImpl extends SavedTextRepository {
  final FirestoreService _service;
  final SavedTextConverter _savedTextConverter;

  SavedTextRepositoryImpl(
    this._service,
    this._savedTextConverter,
  );

  @override
  Future<List<SavedText>> getSavedTexts() => _service
      .getSavedTexts()
      .then((list) => list.map(_savedTextConverter.toDomain).toList());

  @override
  Future<void> saveText(SavedText text) =>
      _service.saveText(_savedTextConverter.toData(text));
}
