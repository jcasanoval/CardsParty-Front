import 'package:flutter/material.dart';

class TaggedProgressIndicator extends StatelessWidget {
  const TaggedProgressIndicator({
    super.key,
    this.tag = 'loading',
  });

  final String tag;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 8),
        Text(tag),
      ],
    );
  }
}
