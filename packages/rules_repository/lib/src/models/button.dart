part of 'ui_element.dart';

enum ButtonColor { red, blue, green, yellow }

enum ButtonSize { small, medium, large }

enum ButtonType { outlined, solid, rounded }

final class Button extends UIElement {
  final bool showButton;
  final String buttonLabel;
  final ButtonColor color;
  final ButtonSize size;
  final ButtonType type;
  //final List<Player> players;

  Button(
      {required this.showButton,
      required this.buttonLabel,
      required this.color,
      required this.size,
      required this.type});
  //required this.players});
}
