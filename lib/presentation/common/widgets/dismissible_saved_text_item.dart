import 'package:english_words/domain/model/saved_text/saved_text.dart';
import 'package:english_words/presentation/common/widgets/saved_text_item.dart';
import 'package:english_words/presentation/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class DismissibleSavedTextItem extends StatelessWidget {
  final SavedText item;
  final Color backgroundColor;
  final void Function(SavedText item) onTranslationLongPressed;
  final void Function(SavedText item) onTranscriptionPressed;
  final void Function(SavedText item) onTranscriptionLongPressed;
  final void Function(SavedText item) onItemSwipedRight;
  final void Function(SavedText item) onItemSwipedLeft;
  final void Function(String text) onTranslateClicked;
  final void Function(String text) onTranslateAndSaveClicked;

  const DismissibleSavedTextItem({
    Key? key,
    required this.item,
    required this.backgroundColor,
    required this.onTranslationLongPressed,
    required this.onTranscriptionPressed,
    required this.onTranscriptionLongPressed,
    required this.onItemSwipedRight,
    required this.onItemSwipedLeft,
    required this.onTranslateClicked,
    required this.onTranslateAndSaveClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.originalText),
      background: Container(
        color: ThemeProvider.of(context).accentColor,
      ),
      secondaryBackground: Container(
        color: ThemeProvider.of(context).listItemDelete,
      ),
      direction: DismissDirection.horizontal,
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          onItemSwipedRight(item);
        } else if (direction == DismissDirection.endToStart) {
          onItemSwipedLeft(item);
        }
      },
      child: SavedTextItem(
        item: item,
        backgroundColor: backgroundColor,
        onTranslationLongPressed: onTranslationLongPressed,
        onTranscriptionPressed: onTranscriptionPressed,
        onTranscriptionLongPressed: onTranscriptionLongPressed,
        onTranslateClicked: onTranslateClicked,
        onTranslateAndSaveClicked: onTranslateAndSaveClicked,
      ),
    );
  }
}
