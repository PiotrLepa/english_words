import 'package:english_words/domain/model/saved_text/saved_text.dart';

abstract class SavedTextRepository {
  Future<void> save(SavedText text);

  Future<List<SavedText>> getTextsToLearn();

  Future<void> update(SavedText text);

  Future<void> delete(String id);
}
