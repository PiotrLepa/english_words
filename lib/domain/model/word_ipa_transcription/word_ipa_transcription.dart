import 'package:freezed_annotation/freezed_annotation.dart';

part 'word_ipa_transcription.freezed.dart';

@freezed
class WordIpaTranscription with _$WordIpaTranscription {
  const factory WordIpaTranscription({
    required bool isSuccessful,
    required String text,
  }) = _WordIpaTranscription;
}
