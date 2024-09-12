import 'package:auto_route/auto_route.dart';
import 'package:dogapp/feature/main/main_screen.dart';
import 'package:dogapp/feature/settings/settings_screen.dart';
import 'package:dogapp/feature/splash/splash_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: AppRouter._replaceInRouteName)
class AppRouter extends RootStackRouter {
  static const _replaceInRouteName = 'Screen,Route';

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: MainRoute.page),
    CustomRoute(
      page: SettingsRoute.page,
      fullscreenDialog: true,
      // transitionsBuilder: TransitionsBuilders.slideBottom, // Aşağıdan yukarıya geçiş animasyonu
      // durationInMilliseconds: 300,
    ),
  ];
}