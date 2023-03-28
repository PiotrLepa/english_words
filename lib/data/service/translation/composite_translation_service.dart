import 'package:english_words/data/model/translation/general/translations_response.dart';
import 'package:english_words/data/service/translation/translation_service.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TranslationService)
class CompositeTranslationService implements TranslationService {
  final List<TranslationService> _services;

  CompositeTranslationService(this._services);

  @override
  Future<TranslationsResponse> translate(String text) async {
    final translations = _services.map((service) => service.translate(text));
    return Future.wait(translations)
        .then((responses) => mergeAndDistinctTranslations(responses));
  }

  TranslationsResponse mergeAndDistinctTranslations(
    List<TranslationsResponse> responses,
  ) {
    final translations =
        responses.map((response) => response.translations).flatten().distinct();
    return TranslationsResponse(translations: translations);
  }
}

extension<T> on Iterable<T> {
  List<T> distinct() => toSet().toList();
}

extension<T> on Iterable<Iterable<T>> {
  Iterable<T> flatten() => expand((element) => element);
}
