import 'package:english_words/domain/model/word_definitions/word_definition.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'word_definitions.freezed.dart';

@freezed
class WordDefinitions with _$WordDefinitions {
  const factory WordDefinitions({
    required String word,
    required List<WordDefinition> results,
  }) = _WordDefinitions;
}
