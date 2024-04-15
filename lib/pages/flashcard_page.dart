import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
    );
  }
}