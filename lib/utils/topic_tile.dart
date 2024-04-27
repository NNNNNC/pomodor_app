import 'package:flutter/material.dart';
import 'package:pomodoro_app/utils/custom_box.dart';

class topic_tile extends StatelessWidget {
  final String topic_name;
  final String? description;
  final String? cardSet;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const topic_tile({
    super.key,
    required this.topic_name,
    required this.onDelete,
    this.description,
    this.cardSet,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 5),
      child: GestureDetector(
          onTap: onEdit,
          child: custom_box(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      topic_name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    PopupMenuButton(
                      color: const Color.fromRGBO(48, 48, 48, 0.9),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              onEdit();
                            },
                            child: const Text(
                              'Edit       ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          child: TextButton(
                            onPressed: onDelete,
                            child: const Text(
                              'Delete',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                if (description != null)
                  if (description!.split(" ").last.isNotEmpty)
                    Row(
                      children: [
                        Text(
                          maxLines: null,
                          overflow: TextOverflow.ellipsis,
                          description!,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                Row(
                  children: [
                    Text(
                      'Flashcard set :',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        cardSet ?? 'Not selected',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
