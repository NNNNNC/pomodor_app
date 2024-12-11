import 'package:flutter/material.dart';

final _formKey = GlobalKey<FormState>();

class add_tile_dialog extends StatelessWidget {
  final TextEditingController controller;
  final TextEditingController? AnswerController;
  final VoidCallback onPressed;
  final bool? isFlashcard;
  final bool? isFlashcardQuestion;

  const add_tile_dialog({
    super.key,
    required this.controller,
    required this.onPressed,
    this.AnswerController,
    this.isFlashcard,
    this.isFlashcardQuestion,
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
              style: TextStyle(fontSize: 13.5),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '';
                }
                return null;
              },
              maxLength: (isFlashcardQuestion ?? false) ? 100 : 20,
              controller: controller,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 3,
              decoration: InputDecoration(
                border: (isFlashcardQuestion ?? false)
                    ? UnderlineInputBorder()
                    : InputBorder.none,
                focusedBorder: (isFlashcardQuestion ?? false)
                    ? UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 1.0,
                        ),
                      )
                    : null,
                hintText: (isFlashcard ?? false)
                    ? "Add new set"
                    : (isFlashcardQuestion ?? false)
                        ? 'Enter Question'
                        : "Add new profile",
              ),
            ),
            if (isFlashcardQuestion ?? false)
              TextFormField(
                style: TextStyle(fontSize: 13.5),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '';
                  }
                  return null;
                },
                maxLength: 100,
                controller: AnswerController,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 3,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 1.0,
                    ),
                  ),
                  hintText: 'Enter Answer',
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
                        fontSize: 13,
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
                        fontSize: 13,
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
