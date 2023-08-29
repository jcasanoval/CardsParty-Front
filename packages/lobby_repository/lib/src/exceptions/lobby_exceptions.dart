import 'package:flutter/foundation.dart';

@immutable
sealed class LobbyException implements Exception {
  const LobbyException(this.message);

  final String message;
}

final class LobbyNotFoundException extends LobbyException {
  const LobbyNotFoundException() : super('Lobby not found');
}
