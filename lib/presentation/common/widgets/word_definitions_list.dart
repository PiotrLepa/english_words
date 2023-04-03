import 'package:english_words/domain/model/word_definitions/word_definitions.dart';
import 'package:english_words/presentation/common/widgets/word_definition_item.dart';
import 'package:flutter/material.dart';

class WordDefinitionsList extends StatelessWidget {
  final WordDefinitions definitions;

  const WordDefinitionsList({
    Key? key,
    required this.definitions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = definitions.results
        .map((definition) => WordDefinitionItem(wordDefinition: definition))
        .expand((element) => [element, const SizedBox(height: 20)])
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(
          definitions.word,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        ...items,
      ],
    );
  }
}
