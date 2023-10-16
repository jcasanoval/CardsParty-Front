import 'package:game_repository/game_repository.dart';
import '/Users/lalonsotomas/meli/CardsParty-Front/packages/rules_repository/lib/rules_repository.dart';

abstract class GameRuleContract {
  Game applyRule(int userId, Game gameState);
  UIElement? conditionMet(int userId, Game gameState);
}
