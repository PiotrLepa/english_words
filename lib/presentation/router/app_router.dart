import 'package:auto_route/auto_route.dart';
import 'package:english_words/presentation/router/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: HomeRoute.page, path: '/'),
    AutoRoute(page: LearnedTextsRoute.page),
  ];
}
