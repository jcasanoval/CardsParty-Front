sealed class GameException implements Exception {
  const GameException(this.message);

  final String message;

  @override
  String toString() => message;
}

class GameNotFoundException extends GameException {
  const GameNotFoundException(String gameId)
      : super('Game with id $gameId not found');
}
