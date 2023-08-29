// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:cards_party/counter/view/counter_screen.dart' as _i1;
import 'package:cards_party/find_lobby/view/find_lobby_screen.dart' as _i2;
import 'package:cards_party/lobby/view/lobby_screen.dart' as _i3;
import 'package:flutter/material.dart' as _i5;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    CounterRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.CounterScreen(),
      );
    },
    FindLobbyRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.FindLobbyScreen(),
      );
    },
    LobbyRoute.name: (routeData) {
      final args = routeData.argsAs<LobbyRouteArgs>();
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.LobbyScreen(
          lobbyId: args.lobbyId,
          key: args.key,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.CounterScreen]
class CounterRoute extends _i4.PageRouteInfo<void> {
  const CounterRoute({List<_i4.PageRouteInfo>? children})
      : super(
          CounterRoute.name,
          initialChildren: children,
        );

  static const String name = 'CounterRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i2.FindLobbyScreen]
class FindLobbyRoute extends _i4.PageRouteInfo<void> {
  const FindLobbyRoute({List<_i4.PageRouteInfo>? children})
      : super(
          FindLobbyRoute.name,
          initialChildren: children,
        );

  static const String name = 'FindLobbyRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i3.LobbyScreen]
class LobbyRoute extends _i4.PageRouteInfo<LobbyRouteArgs> {
  LobbyRoute({
    required String lobbyId,
    _i5.Key? key,
    List<_i4.PageRouteInfo>? children,
  }) : super(
          LobbyRoute.name,
          args: LobbyRouteArgs(
            lobbyId: lobbyId,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'LobbyRoute';

  static const _i4.PageInfo<LobbyRouteArgs> page =
      _i4.PageInfo<LobbyRouteArgs>(name);
}

class LobbyRouteArgs {
  const LobbyRouteArgs({
    required this.lobbyId,
    this.key,
  });

  final String lobbyId;

  final _i5.Key? key;

  @override
  String toString() {
    return 'LobbyRouteArgs{lobbyId: $lobbyId, key: $key}';
  }
}
