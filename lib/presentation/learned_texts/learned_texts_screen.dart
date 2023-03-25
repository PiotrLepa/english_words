import 'package:auto_route/annotations.dart';
import 'package:english_words/di/dependency_injection.dart';
import 'package:english_words/domain/bloc/learned_texts/learned_texts_bloc.dart';
import 'package:english_words/presentation/extensions.dart';
import 'package:english_words/presentation/learned_texts/learned_texts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LearnedTextsScreen extends StatelessWidget {
  const LearnedTextsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LearnedTextsBloc>()
        ..add(const LearnedTextsEvent.screenStarted()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.strings.learnedTextsAppBarTitle),
        ),
        body: const LearnedTextsPage(),
      ),
    );
  }
}
