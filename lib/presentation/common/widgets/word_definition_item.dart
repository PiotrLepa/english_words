import 'package:english_words/domain/model/word_definitions/word_definition.dart';
import 'package:english_words/presentation/common/widgets/word_definition_item_section.dart';
import 'package:english_words/presentation/extensions.dart';
import 'package:english_words/presentation/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class WordDefinitionItem extends StatelessWidget {
  final WordDefinition wordDefinition;
  final void Function(String text) onTranslateClicked;
  final void Function(String text) onTranslateAndSaveClicked;

  const WordDefinitionItem({
    Key? key,
    required this.wordDefinition,
    required this.onTranslateClicked,
    required this.onTranslateAndSaveClicked,
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
    return _buildSection(
      header: context.strings.wordDefinition,
      contents: [wordDefinition.definition],
    );
  }

  Widget? _getExamples(BuildContext context) {
    final examples = wordDefinition.examples?.toNullIfEmpty();
    if (examples == null) return null;

    return _buildSection(
      header: context.strings.wordExamples,
      contents: examples,
    );
  }

  Widget? _getSynonyms(BuildContext context) {
    final text = wordDefinition.synonyms?.toNullIfEmpty()?.join(', ');
    if (text == null) return null;

    return _buildSection(
      header: context.strings.wordSynonyms,
      contents: [text],
    );
  }

  Widget? _getAntonyms(BuildContext context) {
    final text = wordDefinition.antonyms?.toNullIfEmpty()?.join(', ');
    if (text == null) return null;

    return _buildSection(
      header: context.strings.wordAntonyms,
      contents: [text],
    );
  }

  WordDefinitionItemSection _buildSection({
    required String header,
    required List<String> contents,
  }) {
    return WordDefinitionItemSection(
      header: header,
      contents: contents,
      onTranslateClicked: onTranslateClicked,
      onTranslateAndSaveClicked: onTranslateAndSaveClicked,
    );
  }
}

extension<T> on List<T> {
  List<T>? toNullIfEmpty() => isEmpty ? null : this;
}
