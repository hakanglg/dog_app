import 'package:auto_route/auto_route.dart';
import 'package:dogapp/feature/splash/splash_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {

  @override
  List<AutoRoute> get routes => [
    /// routes go here
    AutoRoute(page: SplashRoute.page, initial: true),
  ];
}