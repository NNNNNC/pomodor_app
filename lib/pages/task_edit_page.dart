import 'package:flutter/material.dart';
import 'package:pomodoro_app/utils/custom_box.dart';

class task_edit_page extends StatefulWidget {
  const task_edit_page({super.key});

  @override
  State<task_edit_page> createState() => _task_edit_pageState();
}

class _task_edit_pageState extends State<task_edit_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.check,
                  size: 30,
                )),
          )
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30, left: 10, bottom: 5),
            child: Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Text(
                  'TASK TITLE',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: custom_box(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Task title',
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
              )),
          Padding(
            padding: EdgeInsets.only(top: 30, left: 10, bottom: 5),
            child: Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Text(
                  'DESCRIPTION',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, top: 3.5),
            child: custom_box(
              child: Stack(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: null, // Set to null for unlimited lines
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: -15,
                    right: -15,
                    child: PopupMenuButton(
                      color: Color.fromRGBO(48, 48, 48, 0.9),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text(
                            'Edit',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        PopupMenuItem(
                          child: Text(
                            'Delete',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
