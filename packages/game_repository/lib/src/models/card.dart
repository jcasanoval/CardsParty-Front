import 'package:equatable/equatable.dart';

const _kNumber = 'number';
const _kSuit = 'suit';

class Card extends Equatable {
  Card({
    required this.number,
    required this.suit,
  });

  final int number;
  final String suit;

  Card.fromJson(Map<String, dynamic> json)
      : number = json[_kNumber]! as int,
        suit = json[_kSuit] as String;

  Map<String, dynamic> toJson() {
    return {
      _kNumber: number,
      _kSuit: suit,
    };
  }

  @override
  List<Object?> get props => [number, suit];
}
