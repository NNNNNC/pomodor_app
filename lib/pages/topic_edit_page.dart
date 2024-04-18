import 'package:flutter/material.dart';
import 'package:pomodoro_app/utils/custom_box.dart';
import 'package:pomodoro_app/utils/task_tile.dart';

class topic_edit_page extends StatefulWidget {
  const topic_edit_page({super.key});

  @override
  State<topic_edit_page> createState() => _topic_edit_pageState();
}

class _topic_edit_pageState extends State<topic_edit_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Topic Title"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
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
                  'TOPIC TITLE',
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
                    Text('Topic title',
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
                  'FLASHCARD SET',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, top: 3.5),
              child: custom_box(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Not selected',
                        style: Theme.of(context).textTheme.titleMedium),
                    Icon(
                      Icons.archive,
                      color: Theme.of(context).colorScheme.secondary,
                    )
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
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: null, // Set to null for unlimited lines
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: -15,
                    right: -15,
                    child: IconButton(onPressed: (){},icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.secondary),)
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30, left: 10, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 5,
                ),
                Text(
                  'TASK',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(
                  width: 300,
                ),
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 3.5),
                child: custom_box(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.add,
                                size: 30,
                                color: Theme.of(context).colorScheme.secondary,
                              ))
                        ],
                      ),
                      task_tile(
                        task_name: "lemonade",
                        taskcompleted: false,
                        onChanged: ((p0) {
                          // write a function here
                        }),
                      ),
                      task_tile(
                        task_name: "lemonade",
                        taskcompleted: false,
                        onChanged: ((p0) {
                          // write a function here
                        }),
                      ),
                      task_tile(
                        task_name: "lemonade",
                        taskcompleted: false,
                        onChanged: ((p0) {
                          // write a function here
                        }),
                      ),
                      task_tile(
                        task_name: "lemonade",
                        taskcompleted: false,
                        onChanged: ((p0) {
                          // write a function here
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
