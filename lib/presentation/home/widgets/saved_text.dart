import 'package:flutter/material.dart';

class SavedText extends StatelessWidget {
  final String originalText;
  final String translation;
  final String ipaTranscription;

  const SavedText({
    Key? key,
    required this.originalText,
    required this.translation,
    required this.ipaTranscription,
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
          child: Text(ipaTranscription),
        ),
        const SizedBox(width: padding),
        Expanded(
          child: Text(translation),
        ),
      ],
    );
  }
}
