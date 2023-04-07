import 'package:english_words/domain/model/saved_text/saved_text.dart';
import 'package:english_words/presentation/common/widgets/saved_text_item.dart';
import 'package:english_words/presentation/common/widgets/saved_text_list_header.dart';
import 'package:flutter/material.dart';

Future<void> showBottomSheetWithTextInfo({
  required BuildContext context,
  required SavedText text,
  required final void Function(SavedText item) onTranslationLongPressed,
  required final void Function(SavedText item) onTranscriptionPressed,
  required final void Function(SavedText item) onTranscriptionLongPressed,
  required final void Function(String text) onTranslateClicked,
  required final void Function(String text) onTranslateAndSaveClicked,
}) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
            maxChildSize: 0.8,
            expand: false,
            builder: (context, scrollController) {
              return Column(
                children: [
                  const SavedTextListHeader(),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: SavedTextItem(
                        item: text,
                        isAlwaysExpanded: true,
                        backgroundColor: Colors.transparent,
                        onTranslationLongPressed: onTranslationLongPressed,
                        onTranscriptionPressed: onTranscriptionPressed,
                        onTranscriptionLongPressed: onTranscriptionLongPressed,
                        onTranslateClicked: onTranslateClicked,
                        onTranslateAndSaveClicked: onTranslateAndSaveClicked,
                      ),
                    ),
                  ),
                ],
              );
            });
      });
}
