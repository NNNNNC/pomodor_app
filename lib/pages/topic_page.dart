import 'package:flutter/material.dart';
import 'package:pomodoro_app/main.dart';
import 'package:pomodoro_app/models/topicModel.dart';
import 'package:pomodoro_app/pages/topic_edit_page.dart';
import 'package:pomodoro_app/user_manual/topicManual_display.dart';
import 'package:pomodoro_app/utils/task_add_dialog.dart';
import 'package:pomodoro_app/utils/topic_tile.dart';

class topic_page extends StatefulWidget {
  const topic_page({super.key});

  @override
  State<topic_page> createState() => _topic_pageState();
}

class _topic_pageState extends State<topic_page> {
  late TextEditingController _topicController;

  @override
  void initState() {
    _topicController = TextEditingController();
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _topicController.dispose();
    super.dispose();
  }

  void createNewTopic() {
    setState(() {
      topicBox.add(TopicModel(name: _topicController.text));
      _topicController.clear();
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: const Text(
            "Topics",
            style: TextStyle(
              fontSize: 18.5,
            ),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(
                Icons.info_outline_rounded,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => topicManualDisplay()),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        height: 50,
        width: 50,
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return TaskAdd(
                  controller: _topicController,
                  onPressed: createNewTopic,
                  isTopic: true,
                );
              },
            );
          },
          child: const Icon(
            Icons.add,
            size: 45,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: topicBox.length,
        itemBuilder: (context, index) {
          var topics = topicBox.getAt(index);
          return topic_tile(
            topic_name: topics!.name!,
            description: topics.description,
            cardSet: flashcardBox.get(topics.cardSet)?.cardSetName,
            onDelete: () {
              setState(() {
                topicBox.deleteAt(index);
              });
            },
            onEdit: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => topic_edit_page(
                    currentIndex: index,
                  ),
                ),
              );
              setState(() {});
            },
          );
        },
      ),
    );
  }
}
