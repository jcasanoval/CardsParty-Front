part of 'find_lobby_cubit.dart';

@immutable
sealed class FindLobbyState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class FindLobbyInitial extends FindLobbyState {}

final class FindLobbyLoading extends FindLobbyState {}

final class LobbyFound extends FindLobbyState {
  LobbyFound({required this.lobbyId});

  final String lobbyId;

  @override
  List<Object?> get props => [lobbyId];
}

final class FindLobbyError extends FindLobbyState {
  FindLobbyError({required this.error});

  final String error;

  @override
  List<Object?> get props => [error];
}
