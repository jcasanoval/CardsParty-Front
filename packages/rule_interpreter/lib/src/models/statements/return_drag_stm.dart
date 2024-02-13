import 'package:game_repository/game_repository.dart';
import 'package:rule_interpreter/rule_interpreter.dart';
import 'package:rules_repository/rules_repository.dart';

/// {@template return_drag_exp}
/// An Expression that returns a drag.
/// {@endtemplate}
class ReturnDragStm extends Statement {
  /// {@macro return_drag_exp}
  const ReturnDragStm({
    required this.enabled,
    required this.visibility,
  });

  /// Whether or not the button is enabled.
  final Expression<bool> enabled;

  final CardVisibility visibility;

  @override
  void evaluate(Game game, String userId, Context context, Card? card) {
    if (context.returned) {
      return;
    }

    final drag = Drag(
      enabled: enabled.evaluate(game, userId, context, card),
      visibility: visibility,
    );
    context
      ..returned = true
      ..returnValue = drag;
  }
}
