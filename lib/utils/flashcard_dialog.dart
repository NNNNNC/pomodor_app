import 'package:flutter/material.dart';
import 'package:pomodoro_app/main.dart';

class FlashcardDialog extends StatefulWidget {
  final int currentIndex;

  const FlashcardDialog({
    super.key,
    required this.currentIndex,
  });

  @override
  State<FlashcardDialog> createState() => _FlashcardDialogState();
}

class _FlashcardDialogState extends State<FlashcardDialog> {
  String? _selectedItem;

  List<String> getCardNames() {
    List<String> listofItems = [];

    listofItems.add('None');

    for (int i = 0; i < flashcardBox.length; i++) {
      var flashcard = flashcardBox.getAt(i)!.cardSetName;
      if (flashcard.isNotEmpty) {
        listofItems.add(flashcard);
      }
    }

    return listofItems;
  }

  @override
  Widget build(BuildContext context) {
    _selectedItem = topicBox.getAt(widget.currentIndex)?.cardSet;

    return AlertDialog(
      contentPadding: const EdgeInsets.only(left: 10.0, top: 18.0),
      title: Text(
        'Select Flashcard',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: SingleChildScrollView(
        child: Column(
          children: getCardNames().map((card) {
            return RadioListTile(
              title: Text(
                card,
                style: const TextStyle(fontSize: 18),
              ),
              value: card,
              groupValue: _selectedItem ?? 'None',
              onChanged: (String? value) {
                setState(() {
                  _selectedItem = value;
                });
              },
              activeColor: Theme.of(context).colorScheme.secondary,
            );
          }).toList(),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            setState(() {
              topicBox.getAt(widget.currentIndex)!.cardSet = _selectedItem;
            });
            Navigator.of(context).pop(_selectedItem);
          },
          child: Text(
            'DONE',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
