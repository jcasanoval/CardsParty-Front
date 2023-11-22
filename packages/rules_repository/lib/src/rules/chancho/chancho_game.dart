import 'package:rules_repository/rules_repository.dart';

const chanchoGame = GameRuleset(
  id: 'chancho',
  name: 'Chancho Va!',
  description: 'A game of Chancho Va!',
  rules: [
    DealCardsRule(),
    ChanchoRule(),
    PassCardRule(),
  ],
);
