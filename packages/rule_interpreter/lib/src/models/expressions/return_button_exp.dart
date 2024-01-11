import 'package:game_repository/game_repository.dart';
import 'package:rule_interpreter/rule_interpreter.dart';
import 'package:rules_repository/rules_repository.dart';

/// {@template return_button_exp}
/// An Expression that returns a button.
/// {@endtemplate}
class ReturnButtonExp extends Expression {
  /// {@macro return_button_exp}
  const ReturnButtonExp({
    required this.buttonLabel,
    required this.color,
    required this.enabled,
    required this.showButton,
    required this.size,
    required this.type,
  });

  /// The label of the button.
  final Statement<String> buttonLabel;

  /// Whether or not the button is enabled.
  final Statement<bool> enabled;

  /// Whether or not the button is shown.
  final Statement<bool> showButton;

  /// The color of the button.
  final ButtonColor color;

  /// The size of the button.
  final ButtonSize size;

  /// The type of the button.
  final ButtonType type;

  @override
  void evaluate(Game game, String userId, Context context, Card? card) {
    if (context.returned) {
      return;
    }

    final button = Button(
      buttonLabel: buttonLabel.evaluate(game, userId, context, card),
      color: color,
      enabled: enabled.evaluate(game, userId, context, card),
      showButton: showButton.evaluate(game, userId, context, card),
      size: size,
      type: type,
    );
    context
      ..returned = true
      ..returnValue = button;
  }
}
