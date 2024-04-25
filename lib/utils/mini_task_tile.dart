import 'package:flutter/material.dart';

class MiniTaskTile extends StatelessWidget {
  final String taskTitle;
  final bool isChecked;
  void Function(bool?)? onChanged;

  MiniTaskTile({
    super.key,
    required this.taskTitle,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0),
      child: Material(
        child: ListTile(
          dense: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
          visualDensity: const VisualDensity(
            horizontal: -4.0,
            vertical: -4.0,
          ),
          tileColor: Colors.grey,
          horizontalTitleGap: 7,
          contentPadding: const EdgeInsets.only(left: 5),
          leading: Checkbox(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            side: const BorderSide(
              color: Color(0xff252525),
              width: 2.0,
            ),
            value: isChecked,
            onChanged: onChanged,
            checkColor: Colors.grey,
          ),
          title: Text(
            taskTitle,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}