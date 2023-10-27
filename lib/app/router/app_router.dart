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
          page: LoadingRoute.page,
          initial: true,
        ),
        AutoRoute(page: FindLobbyRoute.page),
        AutoRoute(page: CounterRoute.page),
        AutoRoute(page: GameRoute.page),
        AutoRoute(page: LobbyRoute.page),
      ];
}
