import 'package:flutter_tts/flutter_tts.dart';
import 'package:injectable/injectable.dart';

@module
abstract class TextToSpeechModule {
  static const _speakLanguage = 'en-US';

  FlutterTts get firestore => FlutterTts()..setLanguage(_speakLanguage);
}
