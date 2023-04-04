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
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(child: firstWidget),
            const VerticalDivider(width: padding),
            Expanded(child: secondWidget),
            const VerticalDivider(width: padding),
            Expanded(child: thirdWidget),
          ],
        ),
      ),
    );
  }
}
