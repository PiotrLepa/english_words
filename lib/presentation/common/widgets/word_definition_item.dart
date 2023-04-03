import 'package:english_words/domain/model/word_definitions/word_definition.dart';
import 'package:flutter/material.dart';

class WordDefinitionItem extends StatelessWidget {
  final WordDefinition wordDefinition;

  const WordDefinitionItem({
    Key? key,
    required this.wordDefinition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getPartOfSpeech(),
        ..._getDefinition(),
        ..._getExamples(),
        ..._getSynonyms(),
        ..._getAntonyms(),
      ],
    );
  }

  Widget _getPartOfSpeech() {
    if (wordDefinition.partOfSpeech == null) return const SizedBox();

    return Column(
      children: [
        Row(
          children: [
            _getHeader('Part of speech: '),
            Text(wordDefinition.partOfSpeech!),
          ],
        ),
        _getDivider(),
      ],
    );
  }

  List<Widget> _getDefinition() {
    return [
      _getHeader('Definition:'),
      Text(wordDefinition.definition),
      _getDivider(),
    ];
  }

  List<Widget> _getExamples() {
    if ((wordDefinition.examples ?? []).isEmpty) return List.empty();

    return [
      _getHeader('Examples:'),
      ...wordDefinition.examples!.map((example) => Text(example)),
      _getDivider(),
    ];
  }

  List<Widget> _getSynonyms() {
    if ((wordDefinition.synonyms ?? []).isEmpty) return List.empty();

    return [
      _getHeader('Synonyms:'),
      Text(wordDefinition.synonyms!.join(', ')),
      _getDivider(),
    ];
  }

  List<Widget> _getAntonyms() {
    if ((wordDefinition.antonyms ?? []).isEmpty) return List.empty();

    return [
      _getHeader('Antonyms:'),
      Text(wordDefinition.synonyms!.join(', ')),
      _getDivider(),
    ];
  }

  Widget _getDivider() {
    return const Divider(height: 1);
  }

  Text _getHeader(String text) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
