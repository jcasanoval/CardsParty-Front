part of 'lobby_screen_cubit.dart';

sealed class LobbyScreenState {}

final class LobbyScreenInitial extends LobbyScreenState {}

final class LobbyLoaded extends LobbyScreenState {
  LobbyLoaded(this.lobby);

  final Lobby lobby;
}

final class LobbyScreenError extends LobbyScreenState {
  LobbyScreenError(this.message);

  final String message;
}

final class GameStarted extends LobbyScreenState {
  GameStarted(this.lobby);

  final Lobby lobby;
}
