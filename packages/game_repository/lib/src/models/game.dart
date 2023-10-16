const _kId = 'id';
const _kPlayerHands = 'playerHands';
const _kPlayers = 'players';
const _kCustomsRulesParams = 'customsRulesParams';

class Game {
  Game(
      {required this.id,
      required this.playerHands,
      required this.players,
      required this.customsRulesParams});

  Game.fromJson(Map<dynamic, dynamic> json)
      : this(
            id: json[_kId] as String,
            playerHands: (json[_kPlayerHands] as List<List<int>>)
                .map((hand) => hand.cast<int?>().toList())
                .toList(),
            players: json[_kPlayers] as List<Player>,
            customsRulesParams:
                json[_kCustomsRulesParams] as Map<String, dynamic>
            );

  final String id;
  final List<List<int?>> playerHands;
  final List<Player> players;
  final Map<String, dynamic> customsRulesParams;

  Map<String, dynamic> toJson() {
    return {
      _kId: id,
      _kPlayerHands: playerHands,
    };
  }
}

class Player {
  final String id;
  final List<int?> cards; // Lista de cartas del jugador

  Player({
    required this.id,
    required this.cards,
  });
}
