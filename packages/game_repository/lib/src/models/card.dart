import 'package:equatable/equatable.dart';

const _kNumber = 'number';
const _kSuit = 'suit';

class Card extends Equatable {
  const Card({
    required this.number,
    required this.suit,
  });

  Card.fromString(String cardString)
      : number = int.parse(cardString.split('-')[0]),
        suit = Suit.fromKey(cardString.split('-')[1]);

  final int number;
  final Suit suit;

  @override
  String toString() {
    return '$number-${suit.key}';
  }

  @override
  List<Object?> get props => [number, suit];
}

enum Suit {
  club('club', '♣'),
  diamond('diamond', '♦'),
  heart('heart', '♥'),
  spade('spade', '♠');

  const Suit(this.key, this.charIcon);

  final String key;
  final String charIcon;

  static Suit fromKey(String key) {
    return Suit.values.firstWhere((element) => element.key == key);
  }
}
