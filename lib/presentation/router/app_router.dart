import 'package:auto_route/annotations.dart';
import 'package:english_words/presentation/home/home_screen.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute<void>(page: HomeScreen, initial: true),
  ],
)
class $AppRouter {}
