part of 'lobby_screen_cubit.dart';

sealed class LobbyScreenState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class LobbyScreenInitial extends LobbyScreenState {}

final class LobbyLoaded extends LobbyScreenState {
  LobbyLoaded(this.lobby);

  final Lobby lobby;

  @override
  List<Object?> get props => [lobby];
}

final class LobbyScreenError extends LobbyScreenState {
  LobbyScreenError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

final class GameStarted extends LobbyScreenState {
  GameStarted(this.lobby);

  final Lobby lobby;

  @override
  List<Object?> get props => [lobby];
}
