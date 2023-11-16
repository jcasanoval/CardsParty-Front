import 'package:rules_repository/rules_repository.dart';

abstract class RulesRepositoryContract {
  Future<GameRuleset> getRules(String rulesetId);
}
