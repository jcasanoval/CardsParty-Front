part 'drag.dart';

sealed class CardAction {
  CardAction({
    required this.enabled,
    this.visibility = CardVisibility.visible,
  });

  final bool enabled;

  final CardVisibility visibility;
}

enum CardVisibility {
  visible,
  hidden,
  back,
}
