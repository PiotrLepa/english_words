import 'package:freezed_annotation/freezed_annotation.dart';

part 'word_definition.freezed.dart';

@freezed
class WordDefinition with _$WordDefinition {
  const factory WordDefinition({
    required String definition,
    String? partOfSpeech,
    List<String>? synonyms,
    List<String>? antonyms,
    List<String>? derivation,
    List<String>? examples,
  }) = _WordDefinition;
}
