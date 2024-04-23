import 'package:flutter/material.dart';
import 'package:pomodoro_app/pages/flashcard_edit.dart';
import 'package:pomodoro_app/utils/custom_box.dart';

class flashcard_tile extends StatelessWidget {
  final String flashcard_name;
  final int flashcard_count;

  const flashcard_tile(
      {super.key, required this.flashcard_name, required this.flashcard_count});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => flashcard_edit()));
        },
        child: custom_box(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(flashcard_name,
                      style: Theme.of(context).textTheme.titleLarge),
                  PopupMenuButton(
                      color: const Color.fromRGBO(48, 48, 48, 0.9),
                      itemBuilder: (context) => const [
                            PopupMenuItem(
                                child: Text(
                              'Edit',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                            PopupMenuItem(
                                child: Text('Delete',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)))
                          ])
                ],
              ),
              Text('$flashcard_count Flashcards')
            ],
          ),
        ),
      ),
    );
  }
}
