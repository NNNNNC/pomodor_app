import 'package:flutter/material.dart';
import 'package:pomodoro_app/pages/flashcard_edit.dart';

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
      padding: const EdgeInsets.only(left: 12, right: 12, top: 7, bottom: 5),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (Context) => flashcard_edit(
                      flashCardIndex: flashCardIndex, onUpdate: onUpdate)));
        },
        child: Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                blurRadius: 1.5,
                spreadRadius: 0,
                offset: const Offset(0, 2),
                color: Colors.black.withOpacity(0.25),
              ),
            ],
          ),
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
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  PopupMenuButton(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        onTap: onDelete,
                        child: Text(
                          'Delete',
                          style: Theme.of(context).popupMenuTheme.textStyle,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Text(
                '$flashcard_count Flashcards',
                style: Theme.of(context).textTheme.labelMedium,
              )
            ],
          ),
        ),
      ),
    );
  }
}
