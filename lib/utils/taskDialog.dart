import 'package:flutter/material.dart';
import 'package:pomodoro_app/utils/mini_task_tile.dart';

class TaskDialog extends StatefulWidget {
  const TaskDialog({
    super.key,
  });

  @override
  State<TaskDialog> createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  List tasks = [
    ['Do chapter 1', false],
    ['Memorize periodic table', false],
    ['Catch fish', false],
    ['Watch movie', false],
    ['Make lemonade', false],
    ['Drink coffee', true],
  ];

  void _taskStatusChange(bool? value, int index) {
    setState(() {
      tasks[index][1] = !tasks[index][1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xff3a3939),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 1.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tasks',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.close_fullscreen,
                        size: 20,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: SizedBox(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return MiniTaskTile(
                          taskTitle: tasks[index][0],
                          isChecked: tasks[index][1],
                          onChanged: (value) => _taskStatusChange(value, index),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
