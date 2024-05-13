import 'package:flutter/material.dart';
import 'package:pomodoro_app/main.dart';
import 'package:pomodoro_app/models/topicModel.dart';
import 'package:pomodoro_app/utils/flashcard_dialog.dart';
import 'package:pomodoro_app/utils/task_add_dialog.dart';
import 'package:pomodoro_app/utils/custom_box.dart';
import 'package:pomodoro_app/utils/task_tile.dart';

class topic_edit_page extends StatefulWidget {
  final int currentIndex;

  const topic_edit_page({
    super.key,
    required this.currentIndex,
  });

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
    _topicController = TextEditingController(
      text: topicBox.getAt(widget.currentIndex)?.name,
    );
    _descriptionController = TextEditingController(
      text: topicBox.getAt(widget.currentIndex)?.description,
    );
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

  void clickcheckbox(int index) {
    setState(() {
      var currentTopic = topicBox.getAt(widget.currentIndex);
      currentTopic!.tasks?[index][1] = !currentTopic.tasks?[index][1];
      currentTopic.save();
    });
  }

  void createNewTask() {
    if (topicBox.getAt(widget.currentIndex)?.tasks != null) {
      setState(() {
        topicBox
            .getAt(widget.currentIndex)!
            .tasks!
            .add([_taskController.text, false]);
        _taskController.clear();
      });
    } else {
      setState(() {
        topicBox.putAt(
            widget.currentIndex,
            TopicModel(name: _topicController.text, tasks: [
              [_taskController.text, false]
            ]));
        _taskController.clear();
      });
    }

    Navigator.of(context).pop();
  }

  int? getCardKey(int index) {
    return topicBox.getAt(index)?.cardSet;
  }

  @override
  Widget build(BuildContext context) {
    var currentTopic = topicBox.getAt(widget.currentIndex);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          cursorColor: Colors.white,
          controller: _topicController,
          style: Theme.of(context).textTheme.titleLarge,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              onPressed: () {
                setState(() {
                  currentTopic!.description = _descriptionController.text;
                  currentTopic.name = _topicController.text;
                  currentTopic.save();
                });

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
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, top: 3.5),
              child: custom_box(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        flashcardBox
                                .get(getCardKey(widget.currentIndex))
                                ?.cardSetName ??
                            'Not selected',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      IconButton(
                        onPressed: () async {
                          await showDialog<void>(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return FlashcardDialog(
                                currentIndex: widget.currentIndex,
                              );
                            },
                          );
                          setState(() {});
                        },
                        icon: Icon(
                          size: 20,
                          Icons.archive,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      )
                    ],
                  ),
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
                    style: Theme.of(context).textTheme.bodySmall,
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
                        maxLines: 1,
                        maxLength: 30,
                        cursorColor: Colors.white,
                        controller: _descriptionController,
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Description Here',
                        ),
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
              padding: const EdgeInsets.only(left: 15.0, right: 8.0, top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TASKS',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return TaskAdd(
                              controller: _taskController,
                              onPressed: createNewTask,
                              isTopic: false,
                            );
                          });
                    },
                    icon: Icon(
                      Icons.add,
                      size: 24,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
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
                        itemCount: currentTopic!.tasks?.length ?? 0,
                        itemBuilder: (context, index) {
                          return task_tile(
                            task_name: currentTopic.tasks![index][0],
                            taskcompleted: currentTopic.tasks![index][1],
                            onChanged: (value) {
                              clickcheckbox(index);
                            },
                            onPressed: () {
                              setState(() {
                                currentTopic.tasks?.removeAt(index);
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
