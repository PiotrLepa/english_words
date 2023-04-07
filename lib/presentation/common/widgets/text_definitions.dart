import 'package:english_words/domain/model/word_definitions/word_definitions.dart';
import 'package:english_words/presentation/common/widgets/word_definitions_list.dart';
import 'package:flutter/material.dart';

class TextDefinitions extends StatelessWidget {
  final String originalText;
  final List<WordDefinitions> definitions;
  final void Function(String text) onTranslateClicked;
  final void Function(String text) onTranslateAndSaveClicked;

  const TextDefinitions({
    Key? key,
    required this.originalText,
    required this.definitions,
    required this.onTranslateClicked,
    required this.onTranslateAndSaveClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = definitions
        .map((wordDefinitions) => WordDefinitionsList(
              showWord: wordDefinitions.word != originalText,
              definitions: wordDefinitions,
              onTranslateClicked: onTranslateClicked,
              onTranslateAndSaveClicked: onTranslateAndSaveClicked,
            ))
        .toList();

    return Column(
      children: items,
    );
  }
}
