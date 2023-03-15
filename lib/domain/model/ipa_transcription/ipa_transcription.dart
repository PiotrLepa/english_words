import 'package:freezed_annotation/freezed_annotation.dart';

part 'ipa_transcription.freezed.dart';

@freezed
class IpaTranscription with _$IpaTranscription {
  const factory IpaTranscription({
    required String dialect,
    required String text,
  }) = _IpaTranscription;
}
