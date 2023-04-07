import 'package:english_words/domain/model/saved_text/saved_text.dart';
import 'package:english_words/presentation/common/widgets/saved_texts_list_with_header.dart';
import 'package:english_words/presentation/home/widgets/home_page_list_placeholder.dart';
import 'package:english_words/presentation/home/widgets/home_text_input.dart';
import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  final List<SavedText> textsToLearn;
  final bool isTranslatingInProgress;
  final TextEditingController textEditController;
  final void Function(String text) onTextSubmitted;
  final void Function(SavedText item) onTranslationLongPressed;
  final void Function(SavedText item) onTranscriptionPressed;
  final void Function(SavedText item) onTranscriptionLongPressed;
  final void Function(SavedText item) onTextAddedToLearned;
  final void Function(SavedText item) onTextDeleted;
  final void Function(String text) onTranslateClicked;
  final void Function(String text) onTranslateAndSaveClicked;

  const HomeContent({
    Key? key,
    required this.textsToLearn,
    required this.isTranslatingInProgress,
    required this.textEditController,
    required this.onTextSubmitted,
    required this.onTranslationLongPressed,
    required this.onTranscriptionPressed,
    required this.onTranscriptionLongPressed,
    required this.onTextAddedToLearned,
    required this.onTextDeleted,
    required this.onTranslateClicked,
    required this.onTranslateAndSaveClicked,
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
        textsToLearn.isEmpty ? const HomePageListPlaceholder() : _buildList(),
      ],
    );
  }

  Widget _buildList() {
    return Expanded(
      child: SavedTextsListWithHeader(
        texts: textsToLearn,
        onTranslationLongPressed: onTranslationLongPressed,
        onTranscriptionPressed: onTranscriptionPressed,
        onTranscriptionLongPressed: onTranscriptionLongPressed,
        onItemSwipedRight: onTextAddedToLearned,
        onItemSwipedLeft: onTextDeleted,
        onTranslateClicked: onTranslateClicked,
        onTranslateAndSaveClicked: onTranslateAndSaveClicked,
      ),
    );
  }
}
