import 'package:flutter/material.dart';
import 'package:pomodoro_app/utils/topic_tile.dart';

class topic_page extends StatefulWidget {
  const topic_page({super.key});

  @override
  State<topic_page> createState() => _topic_pageState();
}

class _topic_pageState extends State<topic_page> {
  List<Widget> topicTiles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Topics"),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'topic',
        onPressed: () {
          setState(() {
            topicTiles.add(
              topic_tile(
                topic_name: 'Lemonade',
                description: "Make lemonade the old fashion way",
              ),
            );
          });
        },
        child: Icon(
          Icons.add,
          size: 45,
        ),
      ),
      body: ListView.builder(
          itemCount: topicTiles.length,
          itemBuilder: (context, index) {
            return topicTiles[index];
          },
        )
    );
  }
}
