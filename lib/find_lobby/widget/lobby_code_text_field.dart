import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LobbyCodeTextField extends StatelessWidget {
  const LobbyCodeTextField({
    required this.controller,
    super.key,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: 'Enter lobby code',
      ),
      maxLength: 4,
      inputFormatters: [
        _UpperCaseTextFormatter(),
      ],
    );
  }
}

class _UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
