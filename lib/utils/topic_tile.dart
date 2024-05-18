import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.only(left: 12, right: 12, top: 7, bottom: 5),
      child: GestureDetector(
          onTap: onEdit,
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        maxLines: 2,
                        topic_name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              onEdit();
                            },
                            child: Text(
                              'Edit       ',
                              style: Theme.of(context).popupMenuTheme.textStyle,
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          child: TextButton(
                            onPressed: onDelete,
                            child: Text(
                              'Delete',
                              style: Theme.of(context).popupMenuTheme.textStyle,
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
                        Flexible(
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            description!,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ],
                    ),
                Row(
                  children: [
                    Text(
                      'Flashcard set :',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        cardSet ?? 'Not selected',
                        style: Theme.of(context).textTheme.labelMedium,
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
