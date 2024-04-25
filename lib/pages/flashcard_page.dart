import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pomodoro_app/main.dart';
import 'package:pomodoro_app/models/flashcardModel.dart';
import 'package:pomodoro_app/utils/flashcard_tile.dart';

class flashcard_page extends StatefulWidget {
  const flashcard_page({super.key});

  @override
  State<flashcard_page> createState() => _flashcard_pageState();
}

class _flashcard_pageState extends State<flashcard_page> {
  void updateFlashcard(int index, int newCount, newCardSetName) {
    setState(() {
      var flashcardSet = flashcardBox.getAt(index);
      flashcardSet!.cards.length = newCount;
      flashcardSet.cardSetName = newCardSetName;
      flashcardBox.putAt(index, flashcardSet);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Flashcards"),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'flashcard',
          onPressed: () {
            setState(() {
              flashcardBox.add(Flashcard(
                cardSetName: 'Card Set Name',
                cards: [
                  {'question': 'Enter Question?', 'answer': 'Enter Answer'},
                ],
              ));
            });
          },
          child: Icon(
            Icons.add,
            size: 45,
          ),
        ),
        body: ListView.builder(
          itemCount: flashcardBox.length,
          itemBuilder: (context, index) {
            var flashcardSet = flashcardBox.getAt(index);
            var cardSetName = flashcardSet?.cardSetName;
            var cardSetLength = flashcardSet?.cards.length;
            return flashcard_tile(
              flashcard_name: cardSetName ?? 'No Name',
              flashcard_count: cardSetLength ?? 0,
              flashCardIndex: index,
              onDelete: () {
                setState(() {
                  flashcardBox.deleteAt(index);
                });
              },
              onUpdate: (newCount, newName) {
                updateFlashcard(index, newCount, newName);
              },
            );
          },
        ));
  }
}
