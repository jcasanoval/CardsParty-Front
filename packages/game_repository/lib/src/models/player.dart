import 'package:equatable/equatable.dart';
import 'package:lobby_repository/lobby_repository.dart';

const _kId = 'id';
const _kName = 'name';
const _kCards = 'cards';

class Player extends Equatable {
  Player({
    required this.id,
    required this.name,
    required this.cards,
  });

  final String id;
  final String name;

  // TODO(lautaro77): update cards type
  final List<int?> cards; // Lista de cartas del jugador

  Player.fromJson(Map<String, dynamic> json)
      : id = json[_kId]! as String,
        cards = json[_kCards] as List<int>? ?? [],
        name = json[_kName]! as String;

  Player.fromLobbyPlayer(LobbyPlayer lobbyPlayer)
      : id = lobbyPlayer.id,
        name = lobbyPlayer.name,
        cards = [];

  Map<String, dynamic> toJson() {
    return {
      _kId: id,
      _kName: name,
      _kCards: cards,
    };
  }

  @override
  List<Object?> get props => [id, name, cards];
}
