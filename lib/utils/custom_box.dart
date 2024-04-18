import 'package:flutter/material.dart';

class custom_box extends StatefulWidget {
  final Widget child;

  custom_box({super.key, required this.child,});

  @override
  State<custom_box> createState() => _custom_boxState();
}

class _custom_boxState extends State<custom_box> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: widget.child,
      decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 44, 44, 44).withOpacity(0.5),
                offset: Offset(0, 3),
                ),
              ],
            ),
    );
  }
}