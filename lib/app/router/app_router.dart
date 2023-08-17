import 'package:auto_route/auto_route.dart';
import 'package:cards_party/app/router/app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Screen,Route',
)
class AppRouter extends $AppRouter {
  AppRouter({
    super.navigatorKey,
  });

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: CounterRoute.page,
          initial: true,
        ),
      ];
}
