import 'dart:convert';
import 'dart:io';

import 'package:english_words/data/converter/deepl_translation_converter.dart';
import 'package:english_words/data/model/translation/deepl/deepl_translations_response.dart';
import 'package:english_words/data/model/translation/general/translations_response.dart';
import 'package:english_words/data/service/translation/translation_service.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@injectable
class DeeplTranslationService implements TranslationService {
  static const _authority = 'api-free.deepl.com';
  static const _path = '/v2/translate';
  static final _headers = <String, String>{
    'Authorization': 'DeepL-Auth-Key bf1c5638-d98c-b84e-9d4c-85818ca9b123:fx',
  };
  static const _sourceLangName = 'source_lang';
  static const _sourceLangValue = 'EN';
  static const _targetLangName = 'target_lang';
  static const _targetLangValue = 'PL';

  static const _textToTranslateName = 'text';

  final DeeplTranslationConverter _responseConverter;

  DeeplTranslationService(this._responseConverter);

  @override
  Future<TranslationsResponse> translate(String text) async {
    final uri = Uri.https(
      _authority,
      _path,
      {
        _sourceLangName: _sourceLangValue,
        _targetLangName: _targetLangValue,
        _textToTranslateName: text,
      },
    );
    return http.post(uri, headers: _headers).then((response) {
      if (response.statusCode == HttpStatus.ok) {
        final json = jsonDecode(utf8.decode(response.bodyBytes));
        return _responseConverter
            .toData(DeeplTranslationsResponse.fromJson(json));
      } else {
        return Future.error(
            Exception(response.toString())); // TODO return meaningful exception
      }
    });
  }
}
