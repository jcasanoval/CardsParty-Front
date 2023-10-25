// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:cards_party/counter/view/counter_screen.dart' as _i1;
import 'package:cards_party/find_lobby/view/find_lobby_screen.dart' as _i2;
import 'package:cards_party/loading_screen/view/loading_screen.dart' as _i3;
import 'package:cards_party/lobby/view/lobby_screen.dart' as _i4;
import 'package:flutter/material.dart' as _i6;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    CounterRoute.name: (routeData) {
      final args = routeData.argsAs<CounterRouteArgs>();
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.CounterScreen(
          gameId: args.gameId,
          key: args.key,
        ),
      );
    },
    FindLobbyRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.FindLobbyScreen(),
      );
    },
    LoadingRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.LoadingScreen(),
      );
    },
    LobbyRoute.name: (routeData) {
      final args = routeData.argsAs<LobbyRouteArgs>();
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.LobbyScreen(
          lobbyId: args.lobbyId,
          key: args.key,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.CounterScreen]
class CounterRoute extends _i5.PageRouteInfo<CounterRouteArgs> {
  CounterRoute({
    required String gameId,
    _i6.Key? key,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          CounterRoute.name,
          args: CounterRouteArgs(
            gameId: gameId,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'CounterRoute';

  static const _i5.PageInfo<CounterRouteArgs> page =
      _i5.PageInfo<CounterRouteArgs>(name);
}

class CounterRouteArgs {
  const CounterRouteArgs({
    required this.gameId,
    this.key,
  });

  final String gameId;

  final _i6.Key? key;

  @override
  String toString() {
    return 'CounterRouteArgs{gameId: $gameId, key: $key}';
  }
}

/// generated route for
/// [_i2.FindLobbyScreen]
class FindLobbyRoute extends _i5.PageRouteInfo<void> {
  const FindLobbyRoute({List<_i5.PageRouteInfo>? children})
      : super(
          FindLobbyRoute.name,
          initialChildren: children,
        );

  static const String name = 'FindLobbyRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.LoadingScreen]
class LoadingRoute extends _i5.PageRouteInfo<void> {
  const LoadingRoute({List<_i5.PageRouteInfo>? children})
      : super(
          LoadingRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoadingRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i4.LobbyScreen]
class LobbyRoute extends _i5.PageRouteInfo<LobbyRouteArgs> {
  LobbyRoute({
    required String lobbyId,
    _i6.Key? key,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          LobbyRoute.name,
          args: LobbyRouteArgs(
            lobbyId: lobbyId,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'LobbyRoute';

  static const _i5.PageInfo<LobbyRouteArgs> page =
      _i5.PageInfo<LobbyRouteArgs>(name);
}

class LobbyRouteArgs {
  const LobbyRouteArgs({
    required this.lobbyId,
    this.key,
  });

  final String lobbyId;

  final _i6.Key? key;

  @override
  String toString() {
    return 'LobbyRouteArgs{lobbyId: $lobbyId, key: $key}';
  }
}
