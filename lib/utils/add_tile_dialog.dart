import 'package:flutter/material.dart';

final _formKey = GlobalKey<FormState>();

class add_tile_dialog extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onPressed;
  final bool? isFlashcard;

  const add_tile_dialog(
      {super.key,
      required this.controller,
      required this.onPressed,
      this.isFlashcard});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
              maxLength: 20,
              controller: controller,
              keyboardType: TextInputType.multiline,
              maxLines: 1,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText:
                    (isFlashcard ?? false) ? "Add new set" : "Add new profile",
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
