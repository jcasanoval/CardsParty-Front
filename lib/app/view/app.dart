import 'package:cards_party/app/app.dart';
import 'package:cards_party/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_repository/game_repository.dart';
import 'package:lobby_repository/lobby_repository.dart';
import 'package:rules_repository/rules_repository.dart';

class App extends StatelessWidget {
  App({super.key})
      : _appRouter = AppRouter(
          navigatorKey: GlobalKey<NavigatorState>(),
        );

  final AppRouter _appRouter;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LobbyRepositoryContract>(
          create: (context) => FirebaseLobbyRepository(),
        ),
        RepositoryProvider<GameRepositoryContract>(
          create: (context) => FirebaseGameRepository(),
        ),
        RepositoryProvider<RulesRepositoryContract>(
          create: (context) => MockRulesRepository(),
        ),
      ],
      child: BlocProvider(
        create: (context) => AuthCubit()..init(),
        child: MaterialApp.router(
          theme: ThemeData(
            appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
            colorScheme: ColorScheme.fromSwatch(
              accentColor: const Color(0xFF13B9FF),
            ),
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: _appRouter.config(),
        ),
      ),
    );
  }
}
