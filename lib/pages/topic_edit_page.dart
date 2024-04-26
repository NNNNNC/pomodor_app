import 'package:flutter/material.dart';
import 'package:pomodoro_app/utils/custom_box.dart';
import 'package:pomodoro_app/utils/task_tile.dart';

class topic_edit_page extends StatefulWidget {
  @override
  _topic_edit_pageState createState() => _topic_edit_pageState();
}

class _topic_edit_pageState extends State<topic_edit_page> {
  TextEditingController _topicController =
      TextEditingController(text: "Topic title");
  TextEditingController _descriptionController =
      TextEditingController(text: "Description");
  bool _isEnabled = false;

  final List taskList = [
    ["lemonade", false],
    ["apple juice", false],
    ["pineapple", true]
  ];

  void clickcheckbox(int index) {
    setState(() {
      taskList[index][1] = !taskList[index][1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Topic Edit"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.check,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 10, bottom: 5),
            child: Row(
              children: [
                const SizedBox(
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
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isEnabled = true;
                        });
                      },
                      child: TextField(
                        controller: _topicController,
                        enabled: _isEnabled,
                        style: Theme.of(context).textTheme.bodyLarge,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          _topicController.text = value;
                        },
                        onSubmitted: (value) {
                          setState(() {
                            _isEnabled = false;
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 10, bottom: 5),
            child: Row(
              children: [
                const SizedBox(
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 10, bottom: 5),
            child: Row(
              children: [
                const SizedBox(
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
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isEnabled = true;
                            });
                          },
                          child: TextField(
                            controller: _descriptionController,
                            enabled: _isEnabled,
                            style: Theme.of(context).textTheme.bodyLarge,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              _descriptionController.text = value;
                            },
                            onSubmitted: (value) {
                              setState(() {
                                _isEnabled = false;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: -15,
                    right: -15,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _isEnabled = true;
                        });
                        TextField(
                          maxLines: 5,
                          minLines: 1,
                          controller: _descriptionController,
                          enabled: _isEnabled,
                          style: Theme.of(context).textTheme.bodyLarge,
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                          onChanged: (value) {
                            _descriptionController.text = value;
                          },
                          onSubmitted: (value) {
                            setState(() {
                              _isEnabled = false;
                            });
                          },
                        );
                      },
                      icon: Icon(Icons.edit,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 8.0, top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'TASK',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.add,
                      size: 24, color: Theme.of(context).colorScheme.secondary),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                  left: 10,
                  bottom: 8.0,
                ),
                child: custom_box(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     const SizedBox(),
                      //     IconButton(
                      //         onPressed: () {},
                      //         icon: Icon(
                      //           Icons.add,
                      //           size: 30,
                      //           color: Theme.of(context).colorScheme.secondary,
                      //         ))
                      //   ],
                      // ),
                      for (int i = 0; i < taskList.length; i++)
                        task_tile(
                          task_name: taskList[i][0],
                          taskcompleted: taskList[i][1],
                          onChanged: ((p0) {
                            clickcheckbox(i);
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
