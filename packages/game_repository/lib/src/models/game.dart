import 'package:game_repository/game_repository.dart';

const _kId = 'id';
const _kPlayers = 'players';
const _KCustomParams = 'customParams';

class Game {
  Game({
    required this.id,
    // this.players = const [],
    this.customParams = const {},
  });

  Game.fromJson(Map<dynamic, dynamic> json)
      : this(
          id: json[_kId] as String,
          // players: (json[_kPlayers] as List<Map<String, dynamic>>)
          //     .map((playerJson) => Player.fromJson(playerJson))
          //     .toList(),
          customParams: json[_KCustomParams] as Map<dynamic, dynamic>? ?? {},
        );

  final String id;
  // final List<Player> players;
  final Map<dynamic, dynamic> customParams;

  Map<String, dynamic> toJson() {
    return {
      _kId: id,
      // _kPlayers: players.map((player) => player.toJson()),
      _KCustomParams: customParams,
    };
  }
}
