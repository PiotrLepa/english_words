import 'package:english_words/data/model/word_definitions/word_definition_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'word_definitions_response.freezed.dart';

part 'word_definitions_response.g.dart';

@freezed
class WordDefinitionsResponse with _$WordDefinitionsResponse {
  @JsonSerializable(explicitToJson: true)
  const factory WordDefinitionsResponse({
    required String word,
    required List<WordDefinitionResponse> results,
  }) = _WordDefinitionsResponse;

  factory WordDefinitionsResponse.fromJson(Map<String, dynamic> json) =>
      _$WordDefinitionsResponseFromJson(json);
}
