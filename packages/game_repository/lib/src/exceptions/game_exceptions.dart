sealed class GameException implements Exception {
  const GameException(this.message);

  final String message;

  @override
  String toString() => message;
}

final class GameNotFoundException extends GameException {
  const GameNotFoundException(String gameId)
      : super('Game with id $gameId not found');
}

final class FailedToUpdateGameException extends GameException {
  const FailedToUpdateGameException() : super('Failed to update game');
}
