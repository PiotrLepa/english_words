import 'dart:convert';
import 'dart:io';

import 'package:english_words/data/model/word_definitions/word_definitions_response.dart';
import 'package:english_words/data/service/word_definitions/word_definitions_service.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@Injectable(as: WordDefinitionsService)
class WordsApiWordsDefinitionsService implements WordDefinitionsService {
  static const _authority = 'wordsapiv1.p.rapidapi.com';
  static const _path = '/words/';
  static final _headers = <String, String>{
    'X-RapidAPI-Key': '53d22d0b0dmsh145530f4e45aea6p104d09jsn989d867e0d2d',
    'X-RapidAPI-Host': 'wordsapiv1.p.rapidapi.com',
  };

  @override
  Future<WordDefinitionsResponse> getWordDefinitions(String word) async {
    final uri = Uri.https(
      _authority,
      '$_path$word',
    );
    return http.get(uri, headers: _headers).then((response) {
      if (response.statusCode == HttpStatus.ok) {
        final json = jsonDecode(utf8.decode(response.bodyBytes));
        return WordDefinitionsResponse.fromJson(json);
      } else {
        return Future.error(
          Exception(utf8.decode(response.bodyBytes)),
        ); // TODO return meaningful exception
      }
    });
  }
}
