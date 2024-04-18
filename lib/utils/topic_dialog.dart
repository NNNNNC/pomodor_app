import 'package:flutter/material.dart';

class TopicDialog extends StatefulWidget {
  const TopicDialog({
    super.key,
  });

  @override
  State<TopicDialog> createState() => _TopicDialogState();
}

class _TopicDialogState extends State<TopicDialog> {
  String? _selectedTopic = "";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
        ),
        width: 250,
        height: 300,
        child: Material(
          child: Column(
            children: [
              RadioListTile(
                title: Text(
                  'Topic 1',
                  style: TextStyle(fontSize: 18, color: Colors.grey[200]),
                ),
                value: 'topic_1',
                groupValue: _selectedTopic,
                onChanged: (String? value) {
                  setState(() {
                    _selectedTopic = value;
                  });
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile(
                title: Text(
                  'Topic 2',
                  style: TextStyle(fontSize: 18, color: Colors.grey[200]),
                ),
                value: 'topic_2',
                groupValue: _selectedTopic,
                onChanged: (String? value) {
                  setState(() {
                    _selectedTopic = value;
                  });
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile(
                title: Text(
                  'Topic 3',
                  style: TextStyle(fontSize: 18, color: Colors.grey[200]),
                ),
                value: 'topic_4',
                groupValue: _selectedTopic,
                onChanged: (String? value) {
                  setState(() {
                    _selectedTopic = value;
                  });
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile(
                title: Text(
                  'Topic 4',
                  style: TextStyle(fontSize: 18, color: Colors.grey[200]),
                ),
                value: 'topic_4',
                groupValue: _selectedTopic,
                onChanged: (String? value) {
                  setState(() {
                    _selectedTopic = value;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
