import 'package:english_words/presentation/extensions.dart';
import 'package:flutter/material.dart';

class WordDefinitionItemSection extends StatelessWidget {
  final String header;
  final List<String> contents;
  final void Function(String text) onTranslateClicked;
  final void Function(String text) onTranslateAndSaveClicked;

  const WordDefinitionItemSection({
    Key? key,
    required this.header,
    required this.contents,
    required this.onTranslateClicked,
    required this.onTranslateAndSaveClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _getHeader(),
        ..._getContents(),
      ],
    );
  }

  Widget _getHeader() {
    return Text(
      header,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Iterable<Widget> _getContents() {
    return contents.map((text) {
      return SelectableText(
        text,
        contextMenuBuilder: _buildContextMenuWithTranslateButtons,
      );
    });
  }

  Widget _buildContextMenuWithTranslateButtons(
    BuildContext context,
    EditableTextState editableTextState,
  ) {
    return AdaptiveTextSelectionToolbar.buttonItems(
      anchors: editableTextState.contextMenuAnchors,
      buttonItems: _getContextMenuButtons(context, editableTextState),
    );
  }

  List<ContextMenuButtonItem> _getContextMenuButtons(
    BuildContext context,
    EditableTextState textState,
  ) {
    String selectedText = _getSelectedText(textState);
    return textState.contextMenuButtonItems
      ..insert(0, _buildTranslateButton(context, selectedText))
      ..insert(1, _buildTranslateAndSaveButton(context, selectedText));
  }

  ContextMenuButtonItem _buildTranslateButton(
    BuildContext context,
    String selectedText,
  ) {
    return ContextMenuButtonItem(
      label: context.strings.contextMenuTranslateButton,
      onPressed: () {
        onTranslateClicked(selectedText);
      },
    );
  }

  ContextMenuButtonItem _buildTranslateAndSaveButton(
    BuildContext context,
    String selectedText,
  ) {
    return ContextMenuButtonItem(
      label: context.strings.contextMenuTranslateAndSaveButton,
      onPressed: () {
        onTranslateAndSaveClicked(selectedText);
      },
    );
  }

  String _getSelectedText(EditableTextState editableTextState) {
    final textEditingValue = editableTextState.textEditingValue;
    return textEditingValue.selection.textInside(textEditingValue.text);
  }
}
