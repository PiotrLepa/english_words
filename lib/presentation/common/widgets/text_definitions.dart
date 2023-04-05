import 'package:english_words/domain/model/word_definitions/word_definitions.dart';
import 'package:english_words/presentation/common/widgets/word_definitions_list.dart';
import 'package:flutter/material.dart';

class TextDefinitions extends StatelessWidget {
  final String originalText;
  final List<WordDefinitions> definitions;

  TextDefinitions({
    Key? key,
    required this.originalText,
    required this.definitions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = definitions
        .map((wordDefinitions) => WordDefinitionsList(
              showWord: wordDefinitions.word != originalText,
              definitions: wordDefinitions,
            ))
        .toList();

    return Column(
      children: items,
    );
  }
}
