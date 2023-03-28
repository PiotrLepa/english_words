import 'package:english_words/data/service/translation/deepl_translation_service.dart';
import 'package:english_words/data/service/translation/google_translation_service.dart';
import 'package:english_words/data/service/translation/translation_service.dart';
import 'package:injectable/injectable.dart';

@module
abstract class TranslationModule {
  List<TranslationService> getTranslationServices(
    GoogleTranslationService googleTranslationService,
    DeeplTranslationService deeplTranslationService,
  ) =>
      [
        googleTranslationService,
        deeplTranslationService,
      ];
}
