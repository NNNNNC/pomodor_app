import 'package:flutter/material.dart';

class TaskAdd extends StatelessWidget {
  final controller;
  VoidCallback onPressed;

  TaskAdd({
    super.key,
    required this.controller,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            maxLength: 27,
            controller: controller,
            keyboardType: TextInputType.multiline,
            maxLines: 2,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Add new task",
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context); // Pop the dialog
                },
                icon: Icon(
                  Icons.cancel,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.save,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
