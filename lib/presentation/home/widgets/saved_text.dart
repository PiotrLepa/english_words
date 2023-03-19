import 'package:english_words/domain/model/word_ipa_transcription/word_ipa_transcription.dart';
import 'package:english_words/gen/fonts.gen.dart';
import 'package:english_words/presentation/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class SavedText extends StatelessWidget {
  final String originalText;
  final String translation;
  final List<WordIpaTranscription> wordsTranscription;
  final Color backgroundColor;

  const SavedText({
    Key? key,
    required this.originalText,
    required this.translation,
    required this.wordsTranscription,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const padding = 8.0;
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Text(originalText),
          ),
          const SizedBox(width: padding),
          Expanded(
            child: _buildTranscription(context),
          ),
          const SizedBox(width: padding),
          Expanded(
            child: Text(translation),
          ),
        ],
      ),
    );
  }

  Widget _buildTranscription(BuildContext context) {
    final textColor = ThemeProvider.of(context).textColor;
    final errorTextColor = ThemeProvider.of(context).errorColor;
    final textSpans = wordsTranscription
        .asMap()
        .entries
        .map((entry) => TextSpan(
              text: entry.value.text +
                  (entry.key == wordsTranscription.length ? '' : ' '),
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
}
