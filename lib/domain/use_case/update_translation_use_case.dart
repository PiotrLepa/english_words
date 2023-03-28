import 'package:english_words/domain/model/saved_text/saved_text.dart';
import 'package:english_words/domain/model/translations/translations.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateTranslationUseCase {
  SavedText invoke(SavedText originalText, String newTranslation) {
    if (originalText.translations.getAsText() == newTranslation) {
      return originalText;
    }

    return getUpdatedText(newTranslation, originalText);
  }

  SavedText getUpdatedText(String newTranslation, SavedText originalText) {
    final translations =
        newTranslation.split(',').map((text) => text.trim()).toList();
    final updatedItem = originalText.copyWith(
        translations: Translations(translations: translations));
    return updatedItem;
  }
}
