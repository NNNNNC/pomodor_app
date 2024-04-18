import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pomodoro_app/utils/flashcard_tile.dart';

class flashcard_page extends StatefulWidget {
  const flashcard_page({super.key});

  @override
  State<flashcard_page> createState() => _flashcard_pageState();
}

class _flashcard_pageState extends State<flashcard_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Flashcards"),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        floatingActionButton: FloatingActionButton(
        heroTag: 'flashcard',
        onPressed: (){},
        child: Icon(Icons.add, size: 45,),
      ),

      body: ListView( 
        children: [
          flashcard_tile(flashcard_name: 'Science', flashcard_count: 4,),
          flashcard_tile(flashcard_name: 'Math', flashcard_count: 10,),
          flashcard_tile(flashcard_name: 'English', flashcard_count: 8,)
        ],
      ),
    );
  }
}