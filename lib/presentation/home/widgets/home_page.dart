import 'package:english_words/domain/model/text_info/text_info.dart';
import 'package:english_words/presentation/home/widgets/saved_text.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final List<TextInfo> savedTexts;

  const HomePage({
    Key? key,
    required this.savedTexts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: savedTexts.length,
      itemBuilder: (context, index) {
        final item = savedTexts[index];
        return SavedText(
          originalText: item.originalText,
          translation: item.translations.first.text,
          ipaTranscription: item.ipaTranscription.text,
        );
      },
    );
  }
}
