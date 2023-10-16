import 'package:game_repository/game_repository.dart';

const _kId = 'id';
const _kPlayerHands = 'playerHands';
const _kPlayers = 'players';
const _KCustomParams = 'customParams';

class Game {
  Game({
    required this.id,
    required this.players,
    required this.customParams,
  });

  Game.fromJson(Map<dynamic, dynamic> json)
      : this(
          id: json[_kId] as String,
          players: json[_kPlayers] as List<Player>,
          customParams: json[_KCustomParams] as Map<String, dynamic>,
        );

  final String id;
  final List<Player> players;
  final Map<String, dynamic> customParams;

  Map<String, dynamic> toJson() {
    return {
      _kId: id,
    };
  }
}
