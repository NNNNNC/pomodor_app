import 'package:flutter/material.dart';

class custom_box_2 extends StatefulWidget {
  final Widget child;

  custom_box_2({
    super.key,
    required this.child,
  });

  @override
  State<custom_box_2> createState() => _custom_box_2State();
}

class _custom_box_2State extends State<custom_box_2> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(
            left: 5.0, right: 15.0, top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: widget.child,
      ),
    );
  }
}
