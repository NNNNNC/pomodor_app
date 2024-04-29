import 'package:flutter/material.dart';

final _formKey = GlobalKey<FormState>();

class TaskAdd extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onPressed;
  final bool? isTopic;

  const TaskAdd({
    super.key,
    required this.controller,
    required this.onPressed,
    this.isTopic,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.only(
        left: 18.0,
        right: 18.0,
        top: 8.0,
        bottom: 4.0,
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '';
                }
                return null;
              },
              maxLength: 30,
              controller: controller,
              keyboardType: TextInputType.multiline,
              maxLines: 1,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: (isTopic ?? false) ? "Add new topic" : "Add new task",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Pop the dialog
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        onPressed();
                      }
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
