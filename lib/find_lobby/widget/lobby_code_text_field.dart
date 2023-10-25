import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LobbyCodeTextField extends StatelessWidget {
  const LobbyCodeTextField({
    super.key,
    required TextEditingController controller,
  }) : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
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
