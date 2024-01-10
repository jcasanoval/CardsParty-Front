import 'package:game_repository/game_repository.dart';
import 'package:rule_interpreter/rule_interpreter.dart';
import 'package:rules_repository/rules_repository.dart';

/// {@template return_drag_exp}
/// An Expression that returns a drag.
/// {@endtemplate}
class ReturnDragExp extends Expression {
  /// {@macro return_drag_exp}
  const ReturnDragExp({
    required this.enabled,
    required this.visibility,
  });

  /// Whether or not the button is enabled.
  final Statement<bool> enabled;

  final CardVisibility visibility;

  @override
  void evaluate(Game game, String userId, Context context, [Card? card]) {
    if (context.returned) {
      return;
    }

    final drag = Drag(
      enabled: enabled.evaluate(game, userId, context),
      visibility: visibility,
    );
    context
      ..returned = true
      ..returnValue = drag;
  }
}
