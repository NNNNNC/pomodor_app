import 'package:flutter/material.dart';
import 'package:pomodoro_app/main.dart';
import 'package:pomodoro_app/models/selectedModel.dart';

class TopicDialog extends StatefulWidget {
  const TopicDialog({
    super.key,
  });

  @override
  State<TopicDialog> createState() => _TopicDialogState();
}

class _TopicDialogState extends State<TopicDialog> {
  String? _selectedItem;

  Map<String, int> getTopicMap() {
    Map<String, int> topicMap = {};
    topicMap.addAll({"None": -1});

    if (topicBox.isNotEmpty) {
      for (int i = 0; i < topicBox.length; i++) {
        String topic = topicBox.getAt(i)!.name!;
        int key = topicBox.getAt(i)!.key;

        topicMap.addAll({topic: key});
      }
    }
    return topicMap;
  }

  @override
  void initState() {
    int? topicKey = defaultKey.get(0)?.selectedTopic;
    setState(() {
      _selectedItem = topicBox.get(topicKey)?.name ?? 'None';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.only(top: 18.0),
      title: Text(
        'Select Topic',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: SingleChildScrollView(
        child: Column(
          children: getTopicMap().keys.map((topic) {
            return RadioListTile(
              dense: true,
              title: Text(
                topic,
                style: const TextStyle(fontSize: 15),
              ),
              value: topic,
              groupValue: _selectedItem,
              onChanged: (String? value) {
                setState(() {
                  _selectedItem = value;
                });
              },
              activeColor: Theme.of(context).colorScheme.secondary,
            );
          }).toList(),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            setState(() {
              var profile = defaultKey.get(0)?.selectedProfile;
              defaultKey.put(
                0,
                SelectedModel(
                  selectedTopic: (_selectedItem == 'None')
                      ? null
                      : getTopicMap()[_selectedItem],
                  selectedProfile: profile,
                ),
              );
            });
            Navigator.of(context).pop();
          },
          child: Text(
            'DONE',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
