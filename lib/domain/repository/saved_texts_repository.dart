import 'package:english_words/domain/model/text_info/saved_text.dart';

abstract class SavedTextRepository {
  Future<void> saveText(SavedText text);

  Future<List<SavedText>> getSavedTexts();
}
