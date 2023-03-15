import 'package:english_words/di/dependency_injection.dart';
import 'package:english_words/domain/bloc/home_bloc.dart';
import 'package:english_words/presentation/extensions.dart';
import 'package:english_words/presentation/router/app_router.gr.dart';
import 'package:english_words/presentation/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatelessWidget {
  final _appRouter = AppRouter();

  App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeBloc>(),
      child: MaterialApp.router(
        onGenerateTitle: (context) => context.strings.appName,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        theme: ThemeProvider(isDark: false).getThemeData(),
      ),
    );
  }
}