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

  // List<String> getCardNames() {
  //   List<String> listofItems = [];

  //   listofItems.add('None');

  //   for (int i = 0; i < flashcardBox.length; i++) {
  //     var flashcard = flashcardBox.getAt(i)!.cardSetName;
  //     if (flashcard.isNotEmpty) {
  //       listofItems.add(flashcard);
  //     }
  //   }

  //   return listofItems;
  // }

  Map<String, int> getCardMap() {
    Map<String, int> cardMap = {};
    cardMap.addAll({'None': -1});

    for (int i = 0; i < flashcardBox.length; i++) {
      var flashcard = flashcardBox.getAt(i)!.cardSetName;
      var key = flashcardBox.getAt(i)!.key;
      if (flashcard.isNotEmpty) {
        cardMap.addAll({flashcard: key});
      }
    }
    return cardMap;
  }

  @override
  void initState() {
    int? currentKey = topicBox.getAt(widget.currentIndex)?.cardSet;
    setState(() {
      _selectedItem = flashcardBox.get(currentKey)?.cardSetName ?? 'None';
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.only(left: 10.0, top: 18.0),
      title: Text(
        'Select Flashcard',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: SingleChildScrollView(
        child: Column(
          children: getCardMap().keys.map((card) {
            return RadioListTile(
              title: Text(
                card,
                style: const TextStyle(fontSize: 18),
              ),
              value: card,
              groupValue: _selectedItem,
              onChanged: (String? value) {
                setState(() {
                  _selectedItem = card;
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
              if (_selectedItem == 'None') {
                topicBox.getAt(widget.currentIndex)!.cardSet = null;
              } else {
                topicBox.getAt(widget.currentIndex)!.cardSet =
                    getCardMap()[_selectedItem];
              }
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
