import 'package:cards_party/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeNameButton extends StatelessWidget {
  const ChangeNameButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text('Change Name'),
      onPressed: () async {
        final newName = await showDialog<String?>(
            context: context, builder: (_) => _ChangeNameDialog());
        if (newName is String) {
          context.read<AuthCubit>().changeName(newName);
        }
      },
    );
  }
}

// ignore: must_be_immutable
class _ChangeNameDialog extends StatelessWidget {
  _ChangeNameDialog();

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Change Name'),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: const Text('Change'),
          onPressed: () => Navigator.of(context).pop(
            _controller.text.trim().isNotEmpty ? _controller.text.trim() : null,
          ),
        ),
      ],
      content: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
        ),
        child: TextField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: 'New Name',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
