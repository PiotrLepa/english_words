import 'package:english_words/presentation/extensions.dart';
import 'package:english_words/presentation/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class HomePageListPlaceholder extends StatelessWidget {
  const HomePageListPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.strings.homeAddYourFirstTranslation,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.arrow_upward,
            size: 32,
            color: ThemeProvider.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
