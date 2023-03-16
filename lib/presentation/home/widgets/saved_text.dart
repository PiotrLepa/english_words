import 'package:english_words/domain/model/word_ipa_transcription/word_ipa_transcription.dart';
import 'package:english_words/presentation/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class SavedText extends StatelessWidget {
  final String originalText;
  final String translation;
  final List<WordIpaTranscription> wordsTranscription;

  const SavedText({
    Key? key,
    required this.originalText,
    required this.translation,
    required this.wordsTranscription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const padding = 12.0;
    return Row(
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
    );
  }

  Widget _buildTranscription(BuildContext context) {
    final textSpans = wordsTranscription
        .asMap()
        .entries
        .map((entry) => TextSpan(
              text: entry.value.text +
                  (entry.key == wordsTranscription.length ? '' : ' '),
              style: TextStyle(
                color: entry.value.isSuccessful
                    ? null
                    : ThemeProvider.of(context).errorColor,
              ),
            ))
        .toList();

    return RichText(
      text: TextSpan(
        text: '',
        style: DefaultTextStyle.of(context).style,
        children: textSpans,
      ),
    );
  }
}
