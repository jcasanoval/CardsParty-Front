import 'package:auto_route/auto_route.dart';
import 'package:cards_party/counter/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_repository/game_repository.dart';

@RoutePage()
class CounterScreen extends StatelessWidget {
  const CounterScreen({
    required this.gameId,
    super.key,
  });

  final String gameId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(context.read<GameRepositoryContract>())
        ..listenToGame(gameId),
      child: const CounterView(),
    );
  }
}

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: const Center(child: CounterText()),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => context.read<CounterCubit>().increment(),
            heroTag: 'add',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: () => context.read<CounterCubit>().decrement(),
            heroTag: 'remove',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}

class CounterText extends StatelessWidget {
  const CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<CounterCubit, int>(
      builder: (context, state) {
        return Text('$state', style: theme.textTheme.displayLarge);
      },
    );
  }
}
