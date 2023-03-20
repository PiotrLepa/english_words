import 'package:english_words/domain/model/saved_text/saved_text.dart';

abstract class SavedTextRepository {
  Future<void> saveText(SavedText text);

  Future<List<SavedText>> getSavedTexts();
}
