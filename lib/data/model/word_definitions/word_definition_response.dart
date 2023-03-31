import 'package:freezed_annotation/freezed_annotation.dart';

part 'word_definition_response.freezed.dart';

part 'word_definition_response.g.dart';

@freezed
class WordDefinitionResponse with _$WordDefinitionResponse {
  const factory WordDefinitionResponse({
    required String definition,
    String? partOfSpeech,
    List<String>? synonyms,
    List<String>? antonyms,
    List<String>? derivation,
    List<String>? examples,
  }) = _WordDefinitionResponse;

  factory WordDefinitionResponse.fromJson(Map<String, dynamic> json) =>
      _$WordDefinitionResponseFromJson(json);
}
