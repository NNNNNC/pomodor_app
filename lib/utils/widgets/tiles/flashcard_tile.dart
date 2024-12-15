import 'package:flutter/material.dart';
import 'package:pomodoro_app/pages/edit_pages/flashcard_edit.dart';

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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (Context) => flashcard_edit(
              flashCardIndex: flashCardIndex,
              onUpdate: onUpdate,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 6, right: 6, top: 7, bottom: 5),
        child: Container(
          padding:
              const EdgeInsets.only(left: 15, right: 15, bottom: 0, top: 5),
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
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: -20,
                child: PopupMenuButton(
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
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image(
                      image: AssetImage('assets/images/flashcards.png'),
                      width: 150,
                    ),
                    Column(
                      children: [
                        Text(
                          maxLines: 2,
                          flashcard_name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '$flashcard_count Flashcards',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
