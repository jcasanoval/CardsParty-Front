part of 'find_lobby_cubit.dart';

@immutable
sealed class FindLobbyState {}

final class FindLobbyInitial extends FindLobbyState {}

final class FindLobbyLoading extends FindLobbyState {}

final class LobbyFound extends FindLobbyState {
  LobbyFound({required this.lobby});

  final Lobby lobby;
}

final class FindLobbyError extends FindLobbyState {
  FindLobbyError({required this.error});

  final Object error;
}
