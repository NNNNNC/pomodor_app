import 'package:flutter/material.dart';

class flashcard_box extends StatelessWidget {
  final String card_content;
  final String flip_button;
  const flashcard_box(
      {super.key, required this.card_content, required this.flip_button});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Padding(
        padding:
            const EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit,
                    size: 25, color: Theme.of(context).colorScheme.secondary)),
            Center(child: Text(card_content)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(flip_button + ' ',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary)),
                Icon(Icons.arrow_forward,
                    size: 20, color: Theme.of(context).colorScheme.secondary)
              ],
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
