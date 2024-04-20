import 'package:flutter/material.dart';

class custom_box extends StatefulWidget {
  final Widget child;

  custom_box({
    super.key,
    required this.child,
  });

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
            blurRadius: 1.5,
            spreadRadius: 0,
            offset: const Offset(-4, 4),
            color: Colors.black.withOpacity(0.25),
          ),
        ],
      ),
    );
  }
}
