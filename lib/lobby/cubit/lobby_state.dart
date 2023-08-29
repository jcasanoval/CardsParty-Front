part of 'lobby_cubit.dart';

sealed class LobbyState {}

final class LobbyInitial extends LobbyState {}

final class LobbyLoaded extends LobbyState {
  LobbyLoaded(this.lobby);

  final Lobby lobby;
}

final class LobbyError extends LobbyState {
  LobbyError(this.message);

  final String message;
}
