import 'package:flutter/material.dart';

class MiniTaskTile extends StatelessWidget {
  final String taskTitle;
  final bool isChecked;
  final void Function(bool?)? onChanged;

  const MiniTaskTile({
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
          tileColor: Theme.of(context).primaryColor,
          dense: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
          visualDensity: const VisualDensity(
            horizontal: -4.0,
            vertical: -4.0,
          ),
          horizontalTitleGap: 4,
          contentPadding: const EdgeInsets.only(left: 0),
          leading: Checkbox(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            side: const BorderSide(
              color: Color(0xff252525),
              width: 1.5,
            ),
            value: isChecked,
            onChanged: onChanged,
            checkColor: Colors.grey,
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              taskTitle,
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
