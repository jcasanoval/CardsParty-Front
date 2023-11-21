import 'package:equatable/equatable.dart';

const _kNumber = 'number';
const _kSuit = 'suit';

class Card extends Equatable {
  const Card({
    required this.number,
    required this.suit,
  });

  Card.fromJson(Map<String, dynamic> json)
      : number = json[_kNumber]! as String,
        suit = Suit.fromKey(json[_kSuit] as String);

  final String number;
  final Suit suit;

  Map<String, dynamic> toJson() {
    return {
      _kNumber: number,
      _kSuit: suit.key,
    };
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
