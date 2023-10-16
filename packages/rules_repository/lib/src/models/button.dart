part of 'ui_element.dart';

final class Button extends UIElement {
  Button({
    required this.showButton,
    required this.buttonLabel,
    required this.color,
    required this.size,
    required this.type,
    required super.enabled,
  });

  final bool showButton;
  final String buttonLabel;
  final ButtonColor color;
  final ButtonSize size;
  final ButtonType type;
}

enum ButtonColor {
  red,
  blue,
  green,
  yellow,
}

enum ButtonSize {
  small,
  medium,
  large,
}

enum ButtonType {
  outlined,
  solid,
  rounded,
}
