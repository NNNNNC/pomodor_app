import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pomodoro_app/utils/flashcard_tile.dart';

class flashcard_page extends StatefulWidget {
  const flashcard_page({super.key});

  @override
  State<flashcard_page> createState() => _flashcard_pageState();
}

class _flashcard_pageState extends State<flashcard_page> {

  List<Widget> flashcardTiles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Flashcards"),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        floatingActionButton: FloatingActionButton(
        heroTag: 'flashcard',
        onPressed: (){
          setState(() {
              flashcardTiles.add(
                flashcard_tile(
                  flashcard_name: 'Card Set Name', flashcard_count: 1,
                ),
              );
            });
        },
        child: Icon(Icons.add, size: 45,),
      ),

      body: ListView.builder(
          itemCount: flashcardTiles.length,
          itemBuilder: (context, index) {
            return flashcardTiles[index];
          },
        )
    );
  }
}