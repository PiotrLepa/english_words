import 'package:english_words/domain/model/word_definitions/word_definition.dart';
import 'package:english_words/presentation/extensions.dart';
import 'package:english_words/presentation/theme/theme_provider.dart';
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
        ..._getPartOfSpeech(context),
        ..._getDefinition(context),
        ..._getExamples(context),
        ..._getSynonyms(context),
        ..._getAntonyms(context),
      ],
    );
  }

  List<Widget> _getPartOfSpeech(BuildContext context) {
    if (wordDefinition.partOfSpeech == null) return const [];

    return [
      SelectableText(
        wordDefinition.partOfSpeech!,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: ThemeProvider.of(context).primaryColor,
        ),
      ),
      _getSeparator(),
    ];
  }

  List<Widget> _getDefinition(BuildContext context) {
    return [
      _getHeader(context.strings.wordDefinition),
      _getContent(wordDefinition.definition),
      _getSeparator(),
    ];
  }

  List<Widget> _getExamples(BuildContext context) {
    return wordDefinition.examples.ifNotEmpty((items) => [
          _getHeader(context.strings.wordExamples),
          ...items.map((example) => _getContent(example)),
          _getSeparator(),
        ]);
  }

  List<Widget> _getSynonyms(BuildContext context) {
    return wordDefinition.synonyms.ifNotEmpty((items) => [
          _getHeader(context.strings.wordSynonyms),
          _getContent(items.join(', ')),
          _getSeparator(),
        ]);
  }

  List<Widget> _getAntonyms(BuildContext context) {
    return wordDefinition.antonyms.ifNotEmpty((items) => [
          _getHeader(context.strings.wordSynonyms),
          _getContent(items.join(', ')),
          _getSeparator(),
        ]);
  }

  Widget _getHeader(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _getContent(String text) {
    return SelectableText(text);
  }

  Widget _getSeparator() {
    return const SizedBox(height: 8);
  }
}

extension<T> on List<T>? {
  List<Widget> ifNotEmpty(List<Widget> Function(List<T> items) widgetBuilder) {
    if ((this ?? []).isEmpty) return [];
    return widgetBuilder(this!);
  }
}
