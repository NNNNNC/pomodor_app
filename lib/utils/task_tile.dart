import 'package:flutter/material.dart';
import 'package:pomodoro_app/pages/task_edit_page.dart';
import 'package:pomodoro_app/utils/custom_box_2.dart';

class task_tile extends StatelessWidget {
  final String task_name;
  final bool taskcompleted;
  Function(bool?)? onChanged;

  task_tile({
    super.key,
    required this.task_name,
    required this.taskcompleted,
    required this.onChanged,
  });

  void createNewTask(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return task_edit_page();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: GestureDetector(
        onTap: () {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (Context) => const task_edit_page()));
          createNewTask(context);
        },
        child: custom_box_2(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: taskcompleted,
                    onChanged: onChanged,
                    activeColor: Colors.white,
                  ),
                  Text(
                    task_name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 128,
              ),
              Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
