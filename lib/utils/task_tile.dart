import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:overflow_text_animated/overflow_text_animated.dart';

class task_tile extends StatelessWidget {
  final String task_name;
  final bool taskcompleted;
  final Function(bool?)? onChanged;
  final VoidCallback onPressed;

  const task_tile({
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 0),
              child: Checkbox(
                value: taskcompleted,
                onChanged: onChanged,
                activeColor: Theme.of(context).highlightColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                side: BorderSide(
                  color: Theme.of(context).highlightColor,
                ),
              ),
            ),
            Flexible(
              child: Text(
                maxLines: null,
                task_name,
                style: Theme.of(context).textTheme.labelSmall,
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
    );
  }
}
