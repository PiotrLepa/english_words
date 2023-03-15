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
    return Row(
      children: [
        Text(originalText),
        const VerticalDivider(),
        Text(ipaTranscription),
        const VerticalDivider(),
        Text(translation),
      ],
    );
  }
}
