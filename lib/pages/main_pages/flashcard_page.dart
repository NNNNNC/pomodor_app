import 'package:flutter/material.dart';
import 'package:pomodoro_app/main.dart';
import 'package:pomodoro_app/models/flashcardModel.dart';
import 'package:pomodoro_app/utils/widgets/dialogs/add_tile_dialog.dart';
import 'package:pomodoro_app/utils/widgets/tiles/flashcard_tile.dart';

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
          {'Question': '', 'Answer': ''},
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
        title: Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: const Text(
            "Flashcards",
            style: TextStyle(
              fontSize: 18.5,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: GridView.builder(
          itemCount: flashcardBox.length + 1,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            if (index == flashcardBox.length) {
              return GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return add_tile_dialog(
                        controller: _nameController,
                        onPressed: createNewTopic,
                        isFlashcard: true,
                      );
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 6, right: 6, top: 7, bottom: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.50),
                        ),
                        BoxShadow(
                          blurStyle: BlurStyle.inner,
                          blurRadius: 15,
                          spreadRadius: 0,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          size: 50,
                          color: Theme.of(context).highlightColor,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Add New Set",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
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
            }
          },
        ),
      ),
    );
  }
}
