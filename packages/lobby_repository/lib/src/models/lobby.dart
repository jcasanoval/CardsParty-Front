import 'dart:math';

import 'package:lobby_repository/lobby_repository.dart';

const _kId = 'id';
const _kGameCode = 'gameCode';
const _kCreated = 'created';
const _kStatus = 'status';

class Lobby {
  Lobby({
    required this.gameCode,
    required this.created,
    this.id = '',
    this.status = LobbyStatus.waiting,
  });

  /// Creates a new [Lobby] with a random 4 letter game code.
  Lobby.withRandomCode({
    required String id,
    required DateTime created,
  }) : this(
          id: id,
          created: created,
          gameCode: _generateRandomCode(),
        );

  /// Creates a new [Lobby] from a json map.
  Lobby.fromJson(Map<String, Object?> json)
      : this(
          id: json[_kId]! as String,
          gameCode: json[_kGameCode]! as String,
          created: DateTime.parse(json[_kCreated]! as String),
          status: LobbyStatus.fromKey(json[_kStatus]! as String),
        );

  final String id;
  final String gameCode;
  final DateTime created;
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
      _kStatus: status.key,
    };
  }
}
