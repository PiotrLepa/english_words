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
      children: _getItemsWithSeparators([
        _getPartOfSpeech(context),
        _getDefinition(context),
        _getExamples(context),
        _getSynonyms(context),
        _getAntonyms(context),
      ]),
    );
  }

  List<Widget> _getItemsWithSeparators(List<Widget?> items) {
    const separator = SizedBox(height: 8);
    return items
        .whereType<Widget>()
        .expand((element) => [element, separator])
        .toList()
      ..removeLast();
  }

  Widget? _getPartOfSpeech(BuildContext context) {
    if (wordDefinition.partOfSpeech == null) return null;

    return SelectableText(
      wordDefinition.partOfSpeech!,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: ThemeProvider.of(context).primaryColor,
      ),
    );
  }

  Widget? _getDefinition(BuildContext context) {
    return _getSection(
      children: [
        _getHeader(context.strings.wordDefinition),
        _getContent(wordDefinition.definition),
      ],
    );
  }

  Widget? _getExamples(BuildContext context) {
    return _getSectionForList(
      wordDefinition.examples,
      (items) => [
        _getHeader(context.strings.wordExamples),
        ...items.map((example) => _getContent(example)),
      ],
    );
  }

  Widget? _getSynonyms(BuildContext context) {
    return _getSectionForList(
      wordDefinition.synonyms,
      (items) => [
        _getHeader(context.strings.wordSynonyms),
        _getContent(items.join(', ')),
      ],
    );
  }

  Widget? _getAntonyms(BuildContext context) {
    return _getSectionForList(
      wordDefinition.antonyms,
      (items) => [
        _getHeader(context.strings.wordSynonyms),
        _getContent(items.join(', ')),
      ],
    );
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

  Widget? _getSectionForList<T>(
    List<T>? items,
    List<Widget> Function(List<T> items) widgetBuilder,
  ) {
    if ((items ?? []).isEmpty) return null;
    return _getSection(
      children: widgetBuilder(items!),
    );
  }

  Widget? _getSection({
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }
}
