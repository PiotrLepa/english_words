import 'package:english_words/domain/model/saved_text/saved_text.dart';
import 'package:english_words/gen/fonts.gen.dart';
import 'package:english_words/presentation/common/widgets/base_saved_text_list_item.dart';
import 'package:english_words/presentation/common/widgets/text_definitions.dart';
import 'package:english_words/presentation/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class SavedTextItem extends StatefulWidget {
  final SavedText item;
  final Color backgroundColor;
  final void Function(SavedText item) onTranslationLongPressed;
  final void Function(SavedText item) onTranscriptionPressed;
  final void Function(SavedText item) onTranscriptionLongPressed;
  final void Function(SavedText item) onItemSwipedRight;
  final void Function(SavedText item) onItemSwipedLeft;

  const SavedTextItem({
    Key? key,
    required this.item,
    required this.backgroundColor,
    required this.onTranslationLongPressed,
    required this.onTranscriptionPressed,
    required this.onTranscriptionLongPressed,
    required this.onItemSwipedRight,
    required this.onItemSwipedLeft,
  }) : super(key: key);

  @override
  State<SavedTextItem> createState() => _SavedTextItemState();
}

class _SavedTextItemState extends State<SavedTextItem> {
  final _padding = 12.0;
  late final _areDefinitionsPresent = widget.item.definitions != null;
  var _areDefinitionsExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.item.originalText),
      background: Container(
        color: ThemeProvider.of(context).accentColor,
      ),
      secondaryBackground: Container(
        color: ThemeProvider.of(context).listItemDelete,
      ),
      direction: DismissDirection.horizontal,
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          widget.onItemSwipedRight(widget.item);
        } else if (direction == DismissDirection.endToStart) {
          widget.onItemSwipedLeft(widget.item);
        }
      },
      child: Column(
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
          _areDefinitionsPresent && _areDefinitionsExpanded
              ? TextDefinitions(
                  originalText: widget.item.originalText,
                  definitions: widget.item.definitions!,
                )
              : const SizedBox(),
        ],
      ),
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
    if (!_areDefinitionsPresent) return const SizedBox();

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
}
