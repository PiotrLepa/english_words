import 'package:english_words/presentation/extensions.dart';
import 'package:english_words/presentation/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  final String text;
  final String? loadingText;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final bool isLoading;
  final VoidCallback onPressed;

  const LoadingButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.isLoading,
    this.loadingText,
    this.textStyle,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 16),
          Text(
            isLoading
                ? loadingText ?? context.strings.progressButtonLoading
                : text,
            style: textStyle,
          ),
          const SizedBox(width: 16),
          Visibility(
            visible: isLoading,
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(
                  _getProgressColor(context),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Color _getProgressColor(BuildContext context) {
    return textStyle?.color ??
        Theme.of(context)
            .elevatedButtonTheme
            .style
            ?.textStyle
            ?.resolve({MaterialState.focused})?.color ??
        ThemeProvider.of(context).textColorInverted;
  }
}
