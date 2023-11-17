import 'dart:math';

import 'package:flutter/material.dart';

class PlayingCard extends StatelessWidget {
  const PlayingCard({super.key, this.parentRotation = 0});

  static const double width = 57.1;

  static const double height = 88.9;

  final double parentRotation;

  static const suits = ['♥', '♠', '♦', '♣'];
  static const values = [
    'A',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    'J',
    'Q',
    'K',
  ];

  @override
  Widget build(BuildContext context) {
    final cardWidget = DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.black),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            // TODO(jacasanoval): Replace with card data
            '${values.ran}\n${suits.ran}',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );

    return Draggable(
      feedback: Transform.rotate(
        angle: 0.1 + parentRotation,
        child: Transform.scale(
          scale: 1.3,
          child: cardWidget,
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.1,
        child: cardWidget,
      ),
      onDragStarted: () {},
      onDragEnd: (details) {},
      child: cardWidget,
    );
  }
}

extension RandomList<T> on List<T> {
  T get ran => this[Random().nextInt(length)];
}
