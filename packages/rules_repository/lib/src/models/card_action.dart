part 'drag.dart';

sealed class CardAction {
  CardAction({
    required this.enabled,
  });

  final bool enabled;
}
