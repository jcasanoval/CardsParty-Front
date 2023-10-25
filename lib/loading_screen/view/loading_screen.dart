import 'package:auto_route/auto_route.dart';
import 'package:cards_party/app/app.dart';
import 'package:cards_party/app/cubit/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LoadingScreen extends StatefulWidget {
  const LoadingScreen({
    super.key,
  });

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    if (context.read<AuthCubit>().state is Authenticated) {
      context.router.replace(const FindLobbyRoute());
    }
  }

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
