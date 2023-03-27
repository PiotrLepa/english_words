import 'package:english_words/domain/model/saved_text/saved_text.dart';
import 'package:english_words/presentation/common/widgets/saved_texts_list_with_header.dart';
import 'package:english_words/presentation/learned_texts/widgets/learned_words_list_placeholder.dart';
import 'package:flutter/material.dart';

class LearnedTextsContent extends StatelessWidget {
  final void Function(SavedText item) onTranscriptionPressed;
  final void Function(SavedText item) onTranscriptionLongPressed;
  final void Function(SavedText item) onTextMovedToLearn;
  final void Function(SavedText item) onTextDeleted;
  final List<SavedText> learnedTexts;

  const LearnedTextsContent({
    Key? key,
    required this.onTranscriptionPressed,
    required this.onTranscriptionLongPressed,
    required this.onTextMovedToLearn,
    required this.onTextDeleted,
    required this.learnedTexts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        learnedTexts.isEmpty
            ? const LearnedWordsListPlaceholder()
            : _getList(learnedTexts),
      ],
    );
  }

  Widget _getList(List<SavedText> texts) {
    return Expanded(
      child: SavedTextsListWithHeader(
        texts: texts,
        onTranscriptionPressed:onTranscriptionPressed,
        onTranscriptionLongPressed: onTranscriptionLongPressed,
        onItemSwipedRight: onTextMovedToLearn,
        onItemSwipedLeft: onTextDeleted,
      ),
    );
  }
}
