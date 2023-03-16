import 'dart:io';

import 'package:english_words/data/model/ipa_transcription/ipa_transcription_response.dart';
import 'package:english_words/data/service/ipa_transcription/ipa_transcription_service.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;
import 'package:injectable/injectable.dart';

@Injectable(as: IpaTranscriptionService)
class ToPhoneticsIpaTranscriptionService implements IpaTranscriptionService {
  static const _httpMethod = 'POST';
  static const _dialectName = 'dialect';
  static const _dialectValue = 'am';
  static const _fieldText = 'text_to_transcribe';
  static const _headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  static const _idOfElementWithTranscription = 'transcr_output';
  static final _uri = Uri.parse('https://tophonetics.com/');

  @override
  Future<IpaTranscriptionResponse> getIpaTranscription(String text) async {
    try {
      final request = http.Request(_httpMethod, _uri)
        ..headers.addAll(_headers)
        ..bodyFields = {
          _dialectName: _dialectValue,
          _fieldText: text,
        };

      return request.send().then((response) async {
        if (response.statusCode == HttpStatus.ok) {
          String htmlToParse = await response.stream.bytesToString();
          return IpaTranscriptionResponse(
            dialect: _dialectValue,
            text: _extractTranscriptionFromHtml(htmlToParse),
          );
        } else {
          return Future.error(Exception()); // TODO return meaningful exception
        }
      });
    } catch (e) {
      return Future.error(e);
    }
  }

  String _extractTranscriptionFromHtml(String htmlToParse) => html
      .parse(htmlToParse)
      .getElementById(_idOfElementWithTranscription)!
      .children
      .map((element) => element.innerHtml) // TODO mark as invalid if the transcription is displayed as red
      .join(' ');
}