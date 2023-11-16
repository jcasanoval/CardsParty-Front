import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:game_repository/game_repository.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit(this.gameRepository) : super(0);

  late final StreamSubscription<Game> _stream;
  late final String _gameId;

  final GameRepositoryContract gameRepository;

  void listenToGame(String gameId) {
    _gameId = gameId;
    _stream = gameRepository.listenToGame(gameId).listen(
          (game) => emit(game.customParams['value'] as int? ?? 0),
        );
  }

  void increment() {
    gameRepository.updateGame(_gameId, (game) {
      final value = game.customParams['value'] as int? ?? 0;
      game.customParams['value'] = value + 1;
      return game;
    });
  }

  void decrement() {
    gameRepository.updateGame(_gameId, (game) {
      final value = game.customParams['value'] as int? ?? 0;
      game.customParams['value'] = value - 1;
      return game;
    });
  }

  @override
  Future<void> close() {
    _stream.cancel();
    return super.close();
  }
}
