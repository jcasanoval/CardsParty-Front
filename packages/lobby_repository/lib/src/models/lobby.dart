const _kId = 'id';
const _kGameCode = 'gameCode';

class Lobby {
  const Lobby({
    required this.gameCode,
    this.id = '',
  });

  final String id;
  final String gameCode;

  Lobby.fromJson(Map<String, Object?> json)
      : this(
          id: json[_kId]! as String,
          gameCode: json[_kGameCode]! as String,
        );

  Map<String, Object?> toJson() {
    return {
      _kId: id,
      _kGameCode: gameCode,
    };
  }
}
