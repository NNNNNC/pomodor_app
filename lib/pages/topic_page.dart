import 'package:flutter/material.dart';

class topic_page extends StatefulWidget {
  const topic_page({super.key});

  @override
  State<topic_page> createState() => _topic_pageState();
}

class _topic_pageState extends State<topic_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Topics"),
        ),
    );
  }
}