// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:cards_party/counter/view/counter_screen.dart' as _i1;
import 'package:cards_party/find_lobby/view/find_lobby_screen.dart' as _i2;

abstract class $AppRouter extends _i3.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    CounterRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.CounterScreen(),
      );
    },
    FindLobbyRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.FindLobbyScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.CounterScreen]
class CounterRoute extends _i3.PageRouteInfo<void> {
  const CounterRoute({List<_i3.PageRouteInfo>? children})
      : super(
          CounterRoute.name,
          initialChildren: children,
        );

  static const String name = 'CounterRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}

/// generated route for
/// [_i2.FindLobbyScreen]
class FindLobbyRoute extends _i3.PageRouteInfo<void> {
  const FindLobbyRoute({List<_i3.PageRouteInfo>? children})
      : super(
          FindLobbyRoute.name,
          initialChildren: children,
        );

  static const String name = 'FindLobbyRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}
