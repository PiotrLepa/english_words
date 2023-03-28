import 'package:english_words/domain/model/saved_text/saved_text.dart';

abstract class SavedTextRepository {
  Future<SavedText> save(SavedText text);

  Future<SavedText?> getByOriginalText(String originalText);

  Future<List<SavedText>> getTextsToLearn();

  Future<List<SavedText>> getLearnedTexts();

  Future<SavedText> update(SavedText text);

  Future<void> delete(String id);
}
