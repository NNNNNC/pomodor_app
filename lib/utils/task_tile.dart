import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pomodoro_app/utils/task_add_dialog.dart';
import 'package:pomodoro_app/utils/custom_box_2.dart';

class task_tile extends StatelessWidget {
  final String task_name;
  final bool taskcompleted;
  Function(bool?)? onChanged;
  VoidCallback onPressed;

  task_tile({
    super.key,
    required this.task_name,
    required this.taskcompleted,
    required this.onChanged,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: GestureDetector(
        onTap: () {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (Context) => const task_edit_page()));
          // createNewTask(context);
        },
        child: custom_box_2(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Row(
                  children: [
                    Checkbox(
                      value: taskcompleted,
                      onChanged: onChanged,
                      activeColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: null,
                      task_name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.delete_outlined,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
