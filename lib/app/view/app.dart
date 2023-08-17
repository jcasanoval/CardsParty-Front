import 'package:cards_party/app/app.dart';
import 'package:flutter/material.dart';
import 'package:cards_party/counter/counter.dart';
import 'package:cards_party/l10n/l10n.dart';

class App extends StatelessWidget {
  App({super.key})
      : _appRouter = AppRouter(
          navigatorKey: GlobalKey<NavigatorState>(),
        );

  final AppRouter _appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: _appRouter.config(),
    );
  }
}
