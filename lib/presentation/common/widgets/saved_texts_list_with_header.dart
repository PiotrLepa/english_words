import 'package:english_words/domain/model/saved_text/saved_text.dart';
import 'package:english_words/presentation/common/widgets/dismissible_saved_text_item.dart';
import 'package:english_words/presentation/common/widgets/saved_text_item.dart';
import 'package:english_words/presentation/common/widgets/saved_text_list_header.dart';
import 'package:english_words/presentation/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class SavedTextsListWithHeader extends StatelessWidget {
  final List<SavedText> texts;
  final void Function(SavedText item) onTranslationLongPressed;
  final void Function(SavedText item) onTranscriptionPressed;
  final void Function(SavedText item) onTranscriptionLongPressed;
  final void Function(SavedText item) onItemSwipedRight;
  final void Function(SavedText item) onItemSwipedLeft;
  final void Function(String text) onTranslateClicked;
  final void Function(String text) onTranslateAndSaveClicked;

  const SavedTextsListWithHeader({
    super.key,
    required this.texts,
    required this.onTranslationLongPressed,
    required this.onTranscriptionPressed,
    required this.onTranscriptionLongPressed,
    required this.onItemSwipedRight,
    required this.onItemSwipedLeft,
    required this.onTranslateClicked,
    required this.onTranslateAndSaveClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SavedTextListHeader(),
        Expanded(
          child: ListView.separated(
            itemCount: texts.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final item = texts[index];
              return DismissibleSavedTextItem(
                item: item,
                backgroundColor:
                    ThemeProvider.of(context).getListItemColor(index),
                onTranslationLongPressed: onTranslationLongPressed,
                onTranscriptionPressed: onTranscriptionPressed,
                onTranscriptionLongPressed: onTranscriptionLongPressed,
                onItemSwipedRight: onItemSwipedRight,
                onItemSwipedLeft: onItemSwipedLeft,
                onTranslateClicked: onTranslateClicked,
                onTranslateAndSaveClicked: onTranslateAndSaveClicked,
              );
            },
          ),
        ),
      ],
    );
  }
}
