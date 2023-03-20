import 'package:english_words/domain/model/text_info/saved_text.dart';
import 'package:english_words/gen/fonts.gen.dart';
import 'package:english_words/presentation/home/widgets/base_saved_text_list_item.dart';
import 'package:english_words/presentation/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class SavedTextItem extends StatelessWidget {
  final SavedText item;
  final Color backgroundColor;
  final void Function(SavedText item) onItemDeleted;

  const SavedTextItem({
    Key? key,
    required this.item,
    required this.backgroundColor,
    required this.onItemDeleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.originalText),
      background: Container(
        color: ThemeProvider.of(context).listItemDelete,
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        onItemDeleted(item);
      },
      child: BaseSavedTextListItem(
        backgroundDecoration: BoxDecoration(color: backgroundColor),
        firstWidget: Text(item.originalText),
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

    return RichText(
      text: TextSpan(
        text: '',
        children: textSpans,
      ),
    );
  }

  Widget _buildTranslation() {
    final translationsText =
        item.translations.map((translation) => translation.text).join(', ');
    return Text(translationsText);
  }
}
