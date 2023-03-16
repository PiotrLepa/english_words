import 'package:english_words/presentation/extensions.dart';
import 'package:english_words/presentation/home/widgets/loading_button.dart';
import 'package:flutter/material.dart';

class HomeTextInput extends StatefulWidget {
  final void Function(String text) onTextSubmitted;
  final bool isTranslatingInProgress;

  const HomeTextInput({
    Key? key,
    required this.onTextSubmitted,
    required this.isTranslatingInProgress,
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
        LoadingButton(
          onPressed: () {
            widget.onTextSubmitted(textEditController.value.text);
          },
          isLoading: widget.isTranslatingInProgress,
          text: context.strings.homeTranslateButton,
          loadingText: context.strings.homeTranslatingButton,
        ),
      ],
    );
  }
}
