import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pomodoro_app/main.dart';
import 'package:pomodoro_app/models/flashcardModel.dart';
import 'package:pomodoro_app/utils/add_tile_dialog.dart';
import 'package:pomodoro_app/utils/flashcard_tile.dart';

class flashcard_page extends StatefulWidget {
  const flashcard_page({super.key});

  @override
  State<flashcard_page> createState() => _flashcard_pageState();
}

class _flashcard_pageState extends State<flashcard_page> {
  late TextEditingController _nameController;
  void updateFlashcard(int index, int newCount, newCardSetName) {
    setState(() {
      var flashcardSet = flashcardBox.getAt(index);
      flashcardSet!.cards.length = newCount;
      flashcardSet.cardSetName = newCardSetName;
      flashcardBox.putAt(index, flashcardSet);
    });
  }

  void createNewTopic() {
    setState(() {
      flashcardBox.add(Flashcard(
        cardSetName: _nameController.text,
        cards: [
          {'question': '', 'answer': ''},
        ],
      ));
      _nameController.clear();
    });
    Navigator.of(context).pop();
  }

    @override
  void initState() {
    _nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
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
            showDialog(
            context: context,
            builder: (context) {
              return add_tile_dialog(
                controller: _nameController,
                onPressed: createNewTopic,
              );
            },
          );
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
            var cardSetName = flashcardSet!.cardSetName;
            var cardSetLength = flashcardSet.cards.length;
            return flashcard_tile(
              flashcard_name: cardSetName,
              flashcard_count: cardSetLength,
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
