import 'package:english_words/presentation/extensions.dart';
import 'package:flutter/material.dart';

class HomeTextInput extends StatefulWidget {
  final void Function(String text) onTextSubmitted;

  const HomeTextInput({
    Key? key,
    required this.onTextSubmitted,
  }) : super(key: key);

  @override
  State<HomeTextInput> createState() => _HomeTextInputState();
}

class _HomeTextInputState extends State<HomeTextInput> {
  final textEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: textEditController,
            onSubmitted: (text) {
              widget.onTextSubmitted(text);
            },
            maxLines: null,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: context.strings.homeInputHint,
            ),
          ),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: () {
            widget.onTextSubmitted(textEditController.value.text);
          },
          child: Text(
            context.strings.homeTranslateButton,
          ),
        ),
      ],
    );
  }
}
