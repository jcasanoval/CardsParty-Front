part of 'rules_cubit.dart';

sealed class RulesState extends Equatable {
  const RulesState();

  @override
  List<Object> get props => [];
}

final class RulesInitial extends RulesState {}

final class RulesLoading extends RulesState {}

final class RulesLoaded extends RulesState {
  const RulesLoaded({
    this.uiElements = const {},
  });

  final Map<UIElement, GameRuleContract> uiElements;

  @override
  List<Object> get props => [uiElements];
}
