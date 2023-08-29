import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cards_party/bootstrap.dart';
import 'package:game_repository/game_repository.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  late final StreamSubscription<Game> _stream;

  void listenToGame(String gameId) {
    _stream = getIt<GameRepositoryContract>().listenToGame(gameId).listen(
          (game) => emit(game.value),
        );
  }

  void increment() {
    emit(state + 1);
  }

  void decrement() {
    emit(state - 1);
  }

  @override
  Future<void> close() {
    _stream.cancel();
    return super.close();
  }
}
