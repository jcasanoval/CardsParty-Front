import 'package:rules_repository/rules_repository.dart';

const discardDrawGame = GameRuleset(
  id: 'id',
  name: 'name',
  description: 'description',
  rules: [
    DrawCard(),
    DiscardOnDragRule(),
  ],
);
