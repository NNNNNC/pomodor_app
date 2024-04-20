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
    return Container(
      padding: EdgeInsets.all(10),
      child: widget.child,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
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
