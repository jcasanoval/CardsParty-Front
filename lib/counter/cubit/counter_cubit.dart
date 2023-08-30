import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cards_party/bootstrap.dart';
import 'package:game_repository/game_repository.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  late final StreamSubscription<Game> _stream;
  late final String _gameId;

  final _gameRepository = getIt<GameRepositoryContract>();

  void listenToGame(String gameId) {
    _gameId = gameId;
    _stream = _gameRepository.listenToGame(gameId).listen(
          (game) => emit(game.value),
        );
  }

  void increment() {
    _gameRepository.updateGame(_gameId, (game) {
      game.value++;
      return game;
    });
  }

  void decrement() {
    _gameRepository.updateGame(_gameId, (game) {
      game.value--;
      return game;
    });
  }

  @override
  Future<void> close() {
    _stream.cancel();
    return super.close();
  }
}
