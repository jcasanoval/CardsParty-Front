import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:lobby_repository/lobby_repository.dart';

const _kId = 'id';
const _kGameCode = 'gameCode';
const _kCreated = 'created';
const _kHostId = 'hostId';
const _kStatus = 'status';
const _kPlayers = 'players';

class Lobby extends Equatable {
  Lobby({
    required this.gameCode,
    required this.created,
    required this.hostId,
    required this.players,
    this.id = '',
    this.status = LobbyStatus.waiting,
  });

  /// Creates a new [Lobby] with a random 4 letter game code.
  Lobby.withRandomCode({
    required String id,
    required DateTime created,
    required String hostId,
  }) : this(
          id: id,
          created: created,
          hostId: hostId,
          players: [],
          gameCode: _generateRandomCode(),
        );

  /// Creates a new [Lobby] from a json map.
  Lobby.fromJson(Map<String, Object?> json)
      : this(
          id: json[_kId]! as String,
          gameCode: json[_kGameCode]! as String,
          created: DateTime.parse(json[_kCreated]! as String),
          hostId: json[_kHostId]! as String,
          status: LobbyStatus.fromKey(json[_kStatus]! as String),
          players: (json[_kPlayers]! as List<Object?>)
              .map((player) =>
                  LobbyPlayer.fromJson(player! as Map<String, Object?>))
              .toList(),
        );

  final String id;
  final String gameCode;
  final DateTime created;
  String hostId;
  List<LobbyPlayer> players;
  LobbyStatus status;

  static String _generateRandomCode() {
    final random = Random();
    final asciiA = 'A'.codeUnitAt(0);
    final asciiZ = 'Z'.codeUnitAt(0);
    final codeUnits = List.generate(4, (index) {
      return random.nextInt(asciiZ - asciiA + 1) + asciiA;
    });

    return String.fromCharCodes(codeUnits);
  }

  /// Converts a [Lobby] to a json map.
  Map<String, Object?> toJson() {
    return {
      _kId: id,
      _kGameCode: gameCode,
      _kCreated: created.toIso8601String(),
      _kHostId: hostId,
      _kStatus: status.key,
      _kPlayers: players.map((player) => player.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [id, gameCode, created, hostId, players, status];
}
