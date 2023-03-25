import 'package:english_words/presentation/extensions.dart';
import 'package:flutter/material.dart';

class LearnedWordsListPlaceholder extends StatelessWidget {
  const LearnedWordsListPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.strings.learnedTextsNoEntries,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
