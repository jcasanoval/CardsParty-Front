import 'package:auto_route/auto_route.dart';
import 'package:cards_party/app/app.dart';
import 'package:cards_party/app/cubit/auth_cubit/auth_cubit.dart';
import 'package:cards_party/find_lobby/find_lobby.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class FindLobbyScreen extends StatelessWidget {
  const FindLobbyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FindLobbyCubit(),
      child: FindLobbyView(),
    );
  }
}

class FindLobbyView extends StatelessWidget {
  FindLobbyView({super.key});

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<FindLobbyCubit, FindLobbyState>(
      listener: (context, state) {
        if (state is LobbyFound) {
          context.router.push(
            LobbyRoute(lobbyId: state.lobbyId),
          );
        }
        if (state is FindLobbyError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Welcome back ${context.watch<AuthCubit>().currentUser.name}!',
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              LobbyCodeTextField(controller: _controller),
              FindLobbyButton(controller: _controller),
              const CreateLobbyButton(),
              const Spacer(),
              const ChangeNameButton(),
            ],
          ),
        ),
      ),
    );
  }
}
