import 'package:flutter/material.dart';
import 'package:pomodoro_app/pages/flashcard_edit.dart';
import 'package:pomodoro_app/utils/custom_box.dart';

class flashcard_tile extends StatelessWidget {
  final String flashcard_name;
  final int flashcard_count;
  final int flashCardIndex;
  final VoidCallback onDelete;
  final Function(int, String) onUpdate;

  const flashcard_tile({
    super.key,
    required this.flashcard_name,
    required this.flashcard_count,
    required this.flashCardIndex,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (Context) => flashcard_edit(
                      flashCardIndex: flashCardIndex, onUpdate: onUpdate)));
        },
        child: custom_box(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      maxLines: 2,
                      flashcard_name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                 IconButton(onPressed: (){onDelete();}, icon: Icon(Icons.delete_outline,color: Theme.of(context).colorScheme.secondary,))
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
