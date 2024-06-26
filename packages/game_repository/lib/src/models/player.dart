import 'package:equatable/equatable.dart';
import 'package:game_repository/game_repository.dart';
import 'package:lobby_repository/lobby_repository.dart';

const _kId = 'id';
const _kName = 'name';
const _kCards = 'cards';
const _kScore = 'score';
const _kCustomParams = 'customParams';

/// {@template player}
/// A Player.
/// {@endtemplate}
class Player extends Equatable {
  /// {@macro player}
  Player({
    required this.id,
    required this.name,
    required this.cards,
    this.score,
    this.customParams = const {},
  }); // Lista de cartas del jugador

  /// Creates a [Player] from a json object.
  Player.fromJson(Map<String, dynamic> json)
      : id = json[_kId]! as String,
        cards = (json[_kCards] as List<String>? ?? [])
            .map(Card.fromString)
            .toList(),
        customParams = json.containsKey(_kCustomParams)
            ? json[_kCustomParams] as Map<String, dynamic>
            : {},
        name = json[_kName]! as String,
        score = json[_kScore] as int?;

  /// Creates a [Player] from a [LobbyPlayer].
  Player.fromLobbyPlayer(LobbyPlayer lobbyPlayer)
      : id = lobbyPlayer.id,
        name = lobbyPlayer.name,
        customParams = {},
        cards = [],
        score = null;

  /// The id of the player.
  final String id;

  /// The name of the player.
  final String name;

  /// The custom parameters of the player.
  final Map<String, dynamic> customParams;

  /// The players hand.
  final List<Card> cards;

  /// The player's current score.
  int? score;

  /// Creates a json object from a [Player].
  Map<String, dynamic> toJson() {
    return {
      _kId: id,
      _kName: name,
      _kCards: cards.map((card) => card.toString()).toList(),
      _kCustomParams: customParams,
      _kScore: score,
    };
  }

  /// Gets a property from the player.
  dynamic getProperty(String key) {
    switch (key) {
      case _kId:
        return id;
      case _kName:
        return name;
      case _kCards:
        return cards;
      case _kScore:
        return score;
      default:
        return customParams[key];
    }
  }

  @override
  List<Object?> get props => [
        id,
        name,
        cards,
        customParams,
        score,
      ];
}
