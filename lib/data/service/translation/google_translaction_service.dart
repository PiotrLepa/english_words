import 'dart:convert';
import 'dart:io';

import 'package:english_words/data/converter/google_translation_converter.dart';
import 'package:english_words/data/model/translation/general/translations_response.dart';
import 'package:english_words/data/model/translation/google/google_translations_wrapper_response.dart';
import 'package:english_words/data/service/translation/translation_service.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@Injectable(as: TranslationService)
class DeeplTranslationService implements TranslationService {
  static const _authority = 'translation.googleapis.com';
  static const _path = '/language/translate/v2';
  static const _apiKeyName = 'key';
  static const _apiKeyValue = 'AIzaSyAUyXaGJSjk9vguASsJHmXEVlTs1JI1VO8';
  static const _sourceLangName = 'source';
  static const _sourceLangValue = 'EN';
  static const _targetLangName = 'target';
  static const _targetLangValue = 'PL';
  static const _formatName = 'format';
  static const _formatValue = 'text';

  static const _textToTranslateName = 'q';

  final GoogleTranslationConverter _responseConverter;

  DeeplTranslationService(this._responseConverter);

  @override
  Future<TranslationsResponse> translate(String text) async {
    final uri = Uri.https(
      _authority,
      _path,
      {
        _apiKeyName: _apiKeyValue,
        _sourceLangName: _sourceLangValue,
        _targetLangName: _targetLangValue,
        _formatName: _formatValue,
        _textToTranslateName: text,
      },
    );
    return http.post(uri).then((response) {
      if (response.statusCode == HttpStatus.ok) {
        final json = jsonDecode(utf8.decode(response.bodyBytes));
        return _responseConverter
            .toData(GoogleTranslationsWrapperResponse.fromJson(json));
      } else {
        return Future.error(
            Exception(response.toString())); // TODO return meaningful exception
      }
    });
  }
}
