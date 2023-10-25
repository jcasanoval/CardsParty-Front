const _kId = 'id';
const _kName = 'name';

class LobbyPlayer {
  const LobbyPlayer({
    required this.id,
    required this.name,
  });

  /// Creates a new [LobbyPlayer] from a json map.
  LobbyPlayer.fromJson(Map<String, Object?> json)
      : this(
          id: json[_kId]! as String,
          name: json[_kName]! as String,
        );

  final String id;
  final String name;

  /// Converts a [LobbyPlayer] to a json map.
  Map<String, Object?> toJson() {
    return {
      _kId: id,
      _kName: name,
    };
  }
}
