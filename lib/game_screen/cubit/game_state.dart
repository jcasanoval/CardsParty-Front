part of 'game_cubit.dart';

@immutable
sealed class GameState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class GameLoading extends GameState {}

final class GameLoaded extends GameState {
  GameLoaded(this.game);

  final Game game;

  @override
  List<Object?> get props => [game];
}
