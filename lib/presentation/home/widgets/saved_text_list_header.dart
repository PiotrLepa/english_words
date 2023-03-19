import 'package:english_words/presentation/extensions.dart';
import 'package:english_words/presentation/home/widgets/base_saved_text_list_item.dart';
import 'package:english_words/presentation/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class SavedTextListHeader extends StatelessWidget {
  const SavedTextListHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseSavedTextListItem(
      backgroundDecoration: BoxDecoration(
        color: ThemeProvider.of(context).primaryColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
      ),
      firstWidget: _buildText(
        context,
        context.strings.homeSavedTextHeaderOriginalText,
      ),
      secondWidget: _buildText(
        context,
        context.strings.homeSavedTextHeaderTranscription,
      ),
      thirdWidget: _buildText(
        context,
        context.strings.homeSavedTextHeaderTranslation,
      ),
    );
  }

  Text _buildText(BuildContext context, String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: ThemeProvider.of(context).textColorInverted,
      ),
    );
  }
}
