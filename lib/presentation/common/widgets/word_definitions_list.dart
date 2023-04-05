import 'package:english_words/domain/model/word_definitions/word_definitions.dart';
import 'package:english_words/presentation/common/widgets/word_definition_item.dart';
import 'package:english_words/presentation/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class WordDefinitionsList extends StatelessWidget {
  final bool showWord;
  final WordDefinitions definitions;

  const WordDefinitionsList({
    Key? key,
    required this.showWord,
    required this.definitions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = definitions.results
        .map((definition) => WordDefinitionItem(wordDefinition: definition))
        .expand((element) => [element, const SizedBox(height: 12)])
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Visibility(
            visible: showWord,
            child: Text(
              definitions.word,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ThemeProvider.of(context).accentColor,
              ),
            ),
          ),
          ...items,
        ],
      ),
    );
  }
}
