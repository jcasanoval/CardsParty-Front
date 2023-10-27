import 'package:game_repository/game_repository.dart';
import 'package:lobby_repository/lobby_repository.dart';

const _kId = 'id';
const _kPlayers = 'players';
const _kCustomParams = 'customParams';
const _kHostId = 'hostId';

class Game {
  Game({
    required this.id,
    required this.players,
    required this.hostId,
    this.customParams = const {},
  });

  Game.fromJson(Map<String, dynamic> json)
      : this(
          id: json[_kId] as String,
          players: (json[_kPlayers] as List<Map<String, dynamic>>)
              .map(Player.fromJson)
              .toList(),
          customParams: json.containsKey(_kCustomParams)
              ? json[_kCustomParams] as Map<String, dynamic>
              : {},
          hostId: json[_kHostId] as String,
        );

  Game.fromLobby(Lobby lobby)
      : this(
          id: lobby.id,
          players: lobby.players.map(Player.fromLobbyPlayer).toList(),
          hostId: lobby.hostId,
        );

  final String id;
  final List<Player> players;
  final String hostId;
  final Map<String, dynamic> customParams;

  Map<String, Object> toJson() {
    return {
      _kId: id,
      _kPlayers: players.map((player) => player.toJson()).toList(),
      _kCustomParams: customParams,
      _kHostId: hostId,
    };
  }
}
