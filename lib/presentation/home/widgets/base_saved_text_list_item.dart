import 'package:english_words/domain/model/word_ipa_transcription/word_ipa_transcription.dart';
import 'package:english_words/gen/fonts.gen.dart';
import 'package:english_words/presentation/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class BaseSavedTextListItem extends StatelessWidget {
  final Widget firstWidget;
  final Widget secondWidget;
  final Widget thirdWidget;
  final Decoration backgroundDecoration;

  const BaseSavedTextListItem({
    Key? key,
    required this.firstWidget,
    required this.secondWidget,
    required this.thirdWidget,
    required this.backgroundDecoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const padding = 16.0;
    return Container(
      decoration: backgroundDecoration,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: IntrinsicHeight(
        child: Row(
          children: [
            _buildPart(padding: padding, child: firstWidget),
            const VerticalDivider(width: padding),
            _buildPart(padding: padding, child: secondWidget),
            const VerticalDivider(width: padding),
            _buildPart(padding: padding, child: thirdWidget),
          ],
        ),
      ),
    );
  }

  Widget _buildPart({
    required double padding,
    required Widget child,
  }) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: padding),
        child: child,
      ),
    );
  }
}
