import 'package:english_words/data/model/translation/translation_response.dart';
import 'package:english_words/domain/model/translation/translation.dart';
import 'package:injectable/injectable.dart';

@injectable
class TranslationConverter {
  Translation toDomain(TranslationResponse response) =>
      Translation(
        detectedSourceLanguage: response.detectedSourceLanguage,
        text: response.text,
      );
}
