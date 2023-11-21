import 'package:equatable/equatable.dart';
import 'package:game_repository/game_repository.dart';
import 'package:lobby_repository/lobby_repository.dart';

const _kId = 'id';
const _kName = 'name';
const _kCards = 'cards';

class Player extends Equatable {
  const Player({
    required this.id,
    required this.name,
    required this.cards,
  }); // Lista de cartas del jugador

  Player.fromJson(Map<String, dynamic> json)
      : id = json[_kId]! as String,
        cards = (json[_kCards] as List<Map<String, dynamic>>? ?? [])
            .map(Card.fromJson)
            .toList(),
        name = json[_kName]! as String;

  Player.fromLobbyPlayer(LobbyPlayer lobbyPlayer)
      : id = lobbyPlayer.id,
        name = lobbyPlayer.name,
        cards = [];

  final String id;
  final String name;

  final List<Card> cards;

  Map<String, dynamic> toJson() {
    return {
      _kId: id,
      _kName: name,
      _kCards: cards.map((card) => card.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [id, name, cards];
}
