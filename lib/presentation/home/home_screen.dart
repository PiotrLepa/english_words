import 'package:english_words/domain/bloc/home_bloc.dart';
import 'package:english_words/presentation/extensions.dart';
import 'package:english_words/presentation/home/widgets/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.appName),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final savedTexts = state.savedTexts ?? [];
          if (savedTexts.isNotEmpty) {
            return HomePage(savedTexts: savedTexts);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
