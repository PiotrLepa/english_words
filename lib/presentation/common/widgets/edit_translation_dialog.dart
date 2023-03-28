import 'package:english_words/presentation/extensions.dart';
import 'package:flutter/material.dart';

Future<String?> showEditTranslationDialog(
  BuildContext context,
  String initialTranslation,
) async {
  final controller = TextEditingController(text: initialTranslation);
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(context.strings.editTranslation),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              child: Text(context.strings.edit),
              onPressed: () {
                Navigator.pop(context, controller.text);
              },
            ),
          ],
        );
      });
}
