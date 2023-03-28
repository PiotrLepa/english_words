import 'package:english_words/domain/model/saved_text/saved_text.dart';
import 'package:english_words/gen/fonts.gen.dart';
import 'package:english_words/presentation/common/widgets/base_saved_text_list_item.dart';
import 'package:english_words/presentation/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class SavedTextItem extends StatelessWidget {
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
      child: BaseSavedTextListItem(
        backgroundDecoration: BoxDecoration(color: backgroundColor),
        firstWidget: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(item.originalText),
        ),
        secondWidget: _buildTranscription(context),
        thirdWidget: _buildTranslation(),
      ),
    );
  }

  Widget _buildTranscription(BuildContext context) {
    final textColor = ThemeProvider.of(context).textColor;
    final errorTextColor = ThemeProvider.of(context).errorColor;
    final wordsTranscriptions = item.ipaTranscription.words;
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
      onTap: () {
        onTranscriptionPressed(item);
      },
      onLongPress: () {
        onTranscriptionLongPressed(item);
      },
      child: Container(
        height: double.infinity,
        alignment: Alignment.centerLeft,
        color: Colors.transparent,
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
    return GestureDetector(
      onTap: () {
        onTranslationLongPressed(item);
      },
      child: Text(item.translations.getAsText()),
    );
  }
}
