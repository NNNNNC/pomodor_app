import 'package:flutter/material.dart';
import 'package:pomodoro_app/utils/task_add_dialog.dart';
import 'package:pomodoro_app/utils/custom_box.dart';
import 'package:pomodoro_app/utils/task_tile.dart';

class topic_edit_page extends StatefulWidget {
  @override
  _topic_edit_pageState createState() => _topic_edit_pageState();
}

class _topic_edit_pageState extends State<topic_edit_page> {
  late TextEditingController _topicController;
  late TextEditingController _descriptionController;
  late TextEditingController _taskController;

  @override
  void initState() {
    super.initState();
    _topicController = TextEditingController(text: 'Topic Name');
    _descriptionController = TextEditingController();
    _taskController = TextEditingController();
  }

  @override
  void dispose() {
    _topicController.dispose();
    _descriptionController.dispose();
    _taskController.dispose();
    super.dispose();
  }

  bool _isEnabled = false;
  String topicName = '';

  final List taskList = [
    ['lemonade lemonade', false],
  ];

  void clickcheckbox(int index) {
    setState(() {
      taskList[index][1] = !taskList[index][1];
    });
  }

  void createNewTask() {
    setState(() {
      taskList.add([_taskController.text, false]);
      _taskController.clear();
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
            cursorColor: Colors.white,
            controller: _topicController,
            style: Theme.of(context).textTheme.titleLarge,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            onSubmitted: (String text) {
              setState(() {
                topicName = _topicController.text;
              });
            }),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                  crossAxisAlignment: CrossAxisAlignment.center,
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
              child: Stack(
                children: [
                  custom_box(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: TextField(
                        enabled: _isEnabled,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 3,
                        cursorColor: Colors.white,
                        controller: _descriptionController,
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Description Here',
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
                  Positioned(
                    top: -5,
                    right: -5,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _isEnabled = !_isEnabled;
                        });
                      },
                      icon: Icon(_isEnabled ? Icons.edit : Icons.edit_off,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 19),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 8.0, top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TASKS',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return TaskAdd(
                              controller: _taskController,
                              onPressed: createNewTask,
                            );
                          });
                    },
                    icon: Icon(Icons.add,
                        size: 24,
                        color: Theme.of(context).colorScheme.secondary),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: taskList.length,
                        itemBuilder: (context, index) {
                          return task_tile(
                            task_name: taskList[index][0],
                            taskcompleted: taskList[index][1],
                            onChanged: (value) {
                              clickcheckbox(index);
                            },
                            onPressed: () {
                              setState(() {
                                taskList.removeAt(index);
                              });
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
