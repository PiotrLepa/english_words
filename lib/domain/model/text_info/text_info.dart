import 'package:english_words/domain/model/ipa_transcription/ipa_transcription.dart';
import 'package:english_words/domain/model/translation/translation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'text_info.freezed.dart';

@freezed
class TextInfo with _$TextInfo {
  const factory TextInfo({
    required String originalText,
    required List<Translation> translations,
    required IpaTranscription ipaTranscription,
  }) = _TextInfo;
}
