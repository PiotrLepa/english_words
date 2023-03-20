import 'package:english_words/domain/model/saved_text/saved_text.dart';
import 'package:english_words/presentation/extensions.dart';
import 'package:english_words/presentation/home/widgets/home_text_input.dart';
import 'package:english_words/presentation/home/widgets/saved_text_item.dart';
import 'package:english_words/presentation/home/widgets/saved_text_list_header.dart';
import 'package:english_words/presentation/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final void Function(String text) onTextSubmitted;
  final void Function(SavedText item) onTextDeleted;
  final List<SavedText> savedTexts;
  final bool isTranslatingInProgress;
  final TextEditingController textEditController;

  const HomePage({
    Key? key,
    required this.onTextSubmitted,
    required this.onTextDeleted,
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
        savedTexts.isEmpty
            ? _buildPlaceholder(context)
            : _buildList(savedTexts),
      ],
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.strings.homeAddYourFirstTranslation,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.arrow_upward,
            size: 32,
            color: ThemeProvider.of(context).primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildList(List<SavedText> savedTexts) {
    return Expanded(
      child: Column(
        children: [
          const SavedTextListHeader(),
          Expanded(
            child: ListView.separated(
              itemCount: savedTexts.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = savedTexts[index];
                return SavedTextItem(
                  item: item,
                  backgroundColor:
                      ThemeProvider.of(context).getListItemColor(index),
                  onItemDeleted: onTextDeleted,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
