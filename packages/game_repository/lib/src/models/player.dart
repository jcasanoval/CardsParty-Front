class Player {
  Player({
    required this.id,
    required this.cards,
  });

  final String id;
  final List<int?> cards; // Lista de cartas del jugador

  //TODO(Lautaro77): implement fromJson
  Player.fromJson(Map<String, dynamic> json)
      : id = '',
        cards = [];

  //TODO(Lautaro77): implement toJson
  Map<String, dynamic> toJson() {
    return {};
  }
}
