import 'package:game_repository/game_repository.dart';
import 'package:rules_repository/rules_repository.dart';

abstract class CardRuleContract extends RuleContract {
  const CardRuleContract({required super.priority});

  Game applyRule(String userId, Game gameState, Card card);

  CardAction? conditionMet(String userId, Game gameState, Card card);
}
