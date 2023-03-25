import 'package:english_words/domain/model/saved_text/saved_text.dart';
import 'package:english_words/presentation/common/widgets/saved_text_item.dart';
import 'package:english_words/presentation/common/widgets/saved_text_list_header.dart';
import 'package:english_words/presentation/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class SavedTextsListWithHeader extends StatelessWidget {
  final List<SavedText> texts;
  final void Function(SavedText item) onTranscriptionLongPressed;
  final void Function(SavedText item) onTextAddedToLearned;
  final void Function(SavedText item) onTextDeleted;

  const SavedTextsListWithHeader({
    super.key,
    required this.texts,
    required this.onTranscriptionLongPressed,
    required this.onTextAddedToLearned,
    required this.onTextDeleted,
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
              return SavedTextItem(
                item: item,
                backgroundColor:
                    ThemeProvider.of(context).getListItemColor(index),
                onTranscriptionLongPressed: onTranscriptionLongPressed,
                onTextAddedToLearned: onTextAddedToLearned,
                onTextDeleted: onTextDeleted,
              );
            },
          ),
        ),
      ],
    );
  }
}
