import 'package:auto_route/auto_route.dart';
import 'package:english_words/di/dependency_injection.dart';
import 'package:english_words/domain/bloc/home/home_bloc.dart';
import 'package:english_words/presentation/extensions.dart';
import 'package:english_words/presentation/home/home_page.dart';
import 'package:english_words/presentation/router/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeBloc>()..add(const HomeEvent.screenStarted()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.strings.appName),
          actions: [
            IconButton(
              onPressed: () {
                context.router.push(const LearnedTextsRoute());
              },
              icon: const Icon(Icons.save),
            )
          ],
        ),
        body: const HomePage(),
      ),
    );
  }
}
