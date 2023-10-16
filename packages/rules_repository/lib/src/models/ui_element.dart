part 'button.dart';

sealed class UIElement {
  UIElement({
    required this.enabled,
  });

  final bool enabled;
}
