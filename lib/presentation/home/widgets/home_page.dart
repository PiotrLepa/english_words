import 'package:english_words/domain/model/text_info/text_info.dart';
import 'package:english_words/presentation/home/widgets/home_text_input.dart';
import 'package:english_words/presentation/home/widgets/saved_text_item.dart';
import 'package:english_words/presentation/home/widgets/saved_text_list_header.dart';
import 'package:english_words/presentation/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final void Function(String text) onTextSubmitted;
  final List<TextInfo> savedTexts;
  final bool isTranslatingInProgress;
  final TextEditingController textEditController;

  const HomePage({
    Key? key,
    required this.onTextSubmitted,
    required this.savedTexts,
    required this.isTranslatingInProgress,
    required this.textEditController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(16),
          child: HomeTextInput(
            onTextSubmitted: onTextSubmitted,
            isTranslatingInProgress: isTranslatingInProgress,
            textEditController: textEditController,
          ),
        ),
        const SizedBox(height: 16),
        const SavedTextListHeader(),
        Expanded(
          child: _buildListOrPlaceholder(savedTexts),
        ),
      ],
    );
  }

  Widget _buildListOrPlaceholder(List<TextInfo> savedTexts) {
    if (savedTexts.isEmpty) {
      return const Text('Placeholder'); // TODO
    } else {
      return ListView.separated(
        itemCount: savedTexts.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final item = savedTexts[index];
          return SavedTextItem(
            originalText: item.originalText,
            translations: item.translations,
            wordsTranscription: item.ipaTranscription.words,
            backgroundColor: ThemeProvider.of(context).getListItemColor(index),
          );
        },
      );
    }
  }
}
