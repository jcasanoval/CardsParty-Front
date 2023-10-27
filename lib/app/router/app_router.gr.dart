// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:cards_party/counter/view/counter_screen.dart' as _i1;
import 'package:cards_party/find_lobby/view/find_lobby_screen.dart' as _i2;
import 'package:cards_party/game_screen/view/game_screen.dart' as _i3;
import 'package:cards_party/loading_screen/view/loading_screen.dart' as _i4;
import 'package:cards_party/lobby_screen/view/lobby_screen.dart' as _i5;
import 'package:flutter/material.dart' as _i7;

abstract class $AppRouter extends _i6.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    CounterRoute.name: (routeData) {
      final args = routeData.argsAs<CounterRouteArgs>();
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.CounterScreen(
          gameId: args.gameId,
          key: args.key,
        ),
      );
    },
    FindLobbyRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.FindLobbyScreen(),
      );
    },
    GameRoute.name: (routeData) {
      final args = routeData.argsAs<GameRouteArgs>();
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.GameScreen(
          gameId: args.gameId,
          key: args.key,
        ),
      );
    },
    LoadingRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.LoadingScreen(),
      );
    },
    LobbyRoute.name: (routeData) {
      final args = routeData.argsAs<LobbyRouteArgs>();
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.LobbyScreen(
          lobbyId: args.lobbyId,
          key: args.key,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.CounterScreen]
class CounterRoute extends _i6.PageRouteInfo<CounterRouteArgs> {
  CounterRoute({
    required String gameId,
    _i7.Key? key,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          CounterRoute.name,
          args: CounterRouteArgs(
            gameId: gameId,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'CounterRoute';

  static const _i6.PageInfo<CounterRouteArgs> page =
      _i6.PageInfo<CounterRouteArgs>(name);
}

class CounterRouteArgs {
  const CounterRouteArgs({
    required this.gameId,
    this.key,
  });

  final String gameId;

  final _i7.Key? key;

  @override
  String toString() {
    return 'CounterRouteArgs{gameId: $gameId, key: $key}';
  }
}

/// generated route for
/// [_i2.FindLobbyScreen]
class FindLobbyRoute extends _i6.PageRouteInfo<void> {
  const FindLobbyRoute({List<_i6.PageRouteInfo>? children})
      : super(
          FindLobbyRoute.name,
          initialChildren: children,
        );

  static const String name = 'FindLobbyRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.GameScreen]
class GameRoute extends _i6.PageRouteInfo<GameRouteArgs> {
  GameRoute({
    required String gameId,
    _i7.Key? key,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          GameRoute.name,
          args: GameRouteArgs(
            gameId: gameId,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'GameRoute';

  static const _i6.PageInfo<GameRouteArgs> page =
      _i6.PageInfo<GameRouteArgs>(name);
}

class GameRouteArgs {
  const GameRouteArgs({
    required this.gameId,
    this.key,
  });

  final String gameId;

  final _i7.Key? key;

  @override
  String toString() {
    return 'GameRouteArgs{gameId: $gameId, key: $key}';
  }
}

/// generated route for
/// [_i4.LoadingScreen]
class LoadingRoute extends _i6.PageRouteInfo<void> {
  const LoadingRoute({List<_i6.PageRouteInfo>? children})
      : super(
          LoadingRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoadingRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i5.LobbyScreen]
class LobbyRoute extends _i6.PageRouteInfo<LobbyRouteArgs> {
  LobbyRoute({
    required String lobbyId,
    _i7.Key? key,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          LobbyRoute.name,
          args: LobbyRouteArgs(
            lobbyId: lobbyId,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'LobbyRoute';

  static const _i6.PageInfo<LobbyRouteArgs> page =
      _i6.PageInfo<LobbyRouteArgs>(name);
}

class LobbyRouteArgs {
  const LobbyRouteArgs({
    required this.lobbyId,
    this.key,
  });

  final String lobbyId;

  final _i7.Key? key;

  @override
  String toString() {
    return 'LobbyRouteArgs{lobbyId: $lobbyId, key: $key}';
  }
}
