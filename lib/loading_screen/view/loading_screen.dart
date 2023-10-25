import 'package:auto_route/auto_route.dart';
import 'package:cards_party/app/app.dart';
import 'package:cards_party/app/cubit/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CounterView();
  }
}

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          context.router.replace(const FindLobbyRoute());
        }
      },
      child: const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
