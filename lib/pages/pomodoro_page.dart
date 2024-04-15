import 'package:flutter/material.dart';

class pomodoro_page extends StatefulWidget {
  const pomodoro_page({super.key});

  @override
  State<pomodoro_page> createState() => _pomodoro_pageState();
}

class _pomodoro_pageState extends State<pomodoro_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Pomodoro"),
        ),
    );
  }
}