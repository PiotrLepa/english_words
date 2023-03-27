import 'package:english_words/presentation/extensions.dart';
import 'package:flutter/material.dart';

class HomeTextInput extends StatefulWidget {
  final void Function(String text) onTextSubmitted;
  final bool isTranslatingInProgress;
  final TextEditingController textEditController;

  const HomeTextInput({
    Key? key,
    required this.onTextSubmitted,
    required this.isTranslatingInProgress,
    required this.textEditController,
  }) : super(key: key);

  @override
  State<HomeTextInput> createState() => _HomeTextInputState();
}

class _HomeTextInputState extends State<HomeTextInput> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: widget.textEditController,
            onSubmitted: (text) {
              widget.onTextSubmitted(text);
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: context.strings.homeInputHint,
            ),
          ),
        ),
        const SizedBox(width: 16),
        _getButtonOrLoader(),
      ],
    );
  }

  Widget _getButtonOrLoader() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.ease,
      child: widget.isTranslatingInProgress ? _getLoader() : _getFab(),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
    );
  }

  Widget _getFab() {
    return FloatingActionButton(
      onPressed: () {
        widget.onTextSubmitted(widget.textEditController.value.text);
      },
      child: const Icon(Icons.keyboard_arrow_right),
    );
  }

  Widget _getLoader() {
    return const Padding(
      padding: EdgeInsets.all(10),
      child: CircularProgressIndicator(),
    );
  }
}
