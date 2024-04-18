import 'package:flutter/material.dart';
import 'package:pomodoro_app/pages/topic_edit_page.dart';
import 'package:pomodoro_app/utils/custom_box.dart';

class topic_tile extends StatelessWidget {
  final String topic_name;
  final String description;

  const topic_tile({
    super.key,
    required this.topic_name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 5),
      child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (Context) => topic_edit_page()));
          },
          child: custom_box(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(topic_name,
                        style: Theme.of(context).textTheme.titleLarge),
                    PopupMenuButton(
                        color: Color.fromRGBO(48, 48, 48, 0.9),
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                  child: Text(
                                'Edit',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                              PopupMenuItem(
                                  child: Text('Delete',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)))
                            ])
                  ],
                ),
                Row(
                  children: [
                    Text(description,
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
