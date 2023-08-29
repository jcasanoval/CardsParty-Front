/// Enum that represents the state of a lobby.
enum LobbyStatus {
  /// The lobby is waiting for players to join.
  waiting('waiting'),

  /// The lobby has started.
  started('started'),

  /// The lobby has finished.
  finished('finished');

  const LobbyStatus(this.key);

  /// The key of the [LobbyStatus].
  final String key;

  /// Returns the [LobbyStatus] for the given [key].
  static LobbyStatus fromKey(String key) {
    return LobbyStatus.values.firstWhere((element) => element.key == key);
  }
}
