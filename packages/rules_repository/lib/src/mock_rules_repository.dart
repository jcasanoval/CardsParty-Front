import 'package:rules_repository/rules_repository.dart';

/// {@template rules_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class MockRulesRepository extends RulesRepositoryContract {
  @override
  Future<GameRuleset> getRules(String rulesetId) async {
    await Future.delayed(const Duration(seconds: 2));
    return chanchoGame;
  }
}
