import 'package:english_words/domain/model/saved_text/saved_text.dart';
import 'package:english_words/gen/fonts.gen.dart';
import 'package:english_words/presentation/common/widgets/base_saved_text_list_item.dart';
import 'package:english_words/presentation/common/widgets/word_definitions_list.dart';
import 'package:english_words/presentation/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class SavedTextItem extends StatefulWidget {
  final SavedText item;
  final Color backgroundColor;
  final bool isAlwaysExpanded;
  final void Function(SavedText item) onTranslationLongPressed;
  final void Function(SavedText item) onTranscriptionPressed;
  final void Function(SavedText item) onTranscriptionLongPressed;
  final void Function(String text) onTranslateClicked;
  final void Function(String text) onTranslateAndSaveClicked;

  const SavedTextItem({
    Key? key,
    required this.item,
    required this.backgroundColor,
    this.isAlwaysExpanded = false,
    required this.onTranslationLongPressed,
    required this.onTranscriptionPressed,
    required this.onTranscriptionLongPressed,
    required this.onTranslateClicked,
    required this.onTranslateAndSaveClicked,
  }) : super(key: key);

  @override
  State<SavedTextItem> createState() => _SavedTextItemState();
}

class _SavedTextItemState extends State<SavedTextItem> {
  final _padding = 12.0;
  var _areDefinitionsExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BaseSavedTextListItem(
          backgroundDecoration: BoxDecoration(color: widget.backgroundColor),
          firstWidget: Padding(
            padding: EdgeInsets.only(
              top: _padding,
              bottom: _padding,
              left: _padding,
            ),
            child: Text(widget.item.originalText),
          ),
          secondWidget: _buildTranscription(context),
          thirdWidget: _buildTranslation(),
        ),
        _buildDefinitionsIfExpanded(),
      ],
    );
  }

  Widget _buildTranscription(BuildContext context) {
    final textColor = ThemeProvider.of(context).textColor;
    final errorTextColor = ThemeProvider.of(context).errorColor;
    final wordsTranscriptions = widget.item.ipaTranscription.words;
    final textSpans = wordsTranscriptions
        .asMap()
        .entries
        .map((entry) => TextSpan(
              text: entry.value.text +
                  (entry.key == wordsTranscriptions.length ? '' : ' '),
              style: TextStyle(
                fontFamily: FontFamily.firaSans,
                color: entry.value.isSuccessful ? textColor : errorTextColor,
              ),
            ))
        .toList();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        widget.onTranscriptionPressed(widget.item);
      },
      onLongPress: () {
        widget.onTranscriptionLongPressed(widget.item);
      },
      child: Container(
        height: double.infinity,
        alignment: Alignment.centerLeft,
        child: RichText(
          text: TextSpan(
            text: '',
            children: textSpans,
          ),
        ),
      ),
    );
  }

  Widget _buildTranslation() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onLongPress: () {
              widget.onTranslationLongPressed(widget.item);
            },
            child: Text(widget.item.translations.getAsText()),
          ),
        ),
        _getExpandOrCollapseIcon()
      ],
    );
  }

  Widget _getExpandOrCollapseIcon() {
    if (widget.item.definitions == null || widget.isAlwaysExpanded) {
      return const SizedBox();
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          _areDefinitionsExpanded = !_areDefinitionsExpanded;
        });
      },
      child: Container(
        height: double.infinity,
        padding: EdgeInsets.only(right: _padding),
        child: Icon(_areDefinitionsExpanded
            ? Icons.keyboard_arrow_up_rounded
            : Icons.keyboard_arrow_down_rounded),
      ),
    );
  }

  Widget _buildDefinitionsIfExpanded() {
    final definitions = widget.item.definitions;
    return definitions != null &&
            (widget.isAlwaysExpanded || _areDefinitionsExpanded)
        ? WordDefinitionsList(
            showWord: definitions.word != widget.item.originalText,
            definitions: definitions,
            onTranslateClicked: widget.onTranslateClicked,
            onTranslateAndSaveClicked: widget.onTranslateAndSaveClicked,
          )
        : const SizedBox();
  }
}
