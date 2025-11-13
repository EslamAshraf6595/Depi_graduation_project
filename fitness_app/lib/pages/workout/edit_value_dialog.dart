import 'package:flutter/material.dart';

class EditValueDialog extends StatefulWidget {
  final String title;
  final String initialValue;
  final ValueChanged<String> onSave;

  const EditValueDialog({
    super.key,
    required this.title,
    required this.initialValue,
    required this.onSave,
  });

  @override
  State<EditValueDialog> createState() => _EditValueDialogState();
}

class _EditValueDialogState extends State<EditValueDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: _controller,
        autofocus: true,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(labelText: "Enter new value"),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            widget.onSave(_controller.text);
            Navigator.of(context).pop();
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}