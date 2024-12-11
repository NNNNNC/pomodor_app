import 'package:flutter/material.dart';

class audioSelect extends StatefulWidget {
  final TextEditingController controller;
  final Map<String, String> audioMap;
  final Function(String) onTap;

  const audioSelect({
    super.key,
    required this.audioMap,
    required this.onTap,
    required this.controller,
  });

  @override
  State<audioSelect> createState() => _audioDialogState();
}

class _audioDialogState extends State<audioSelect> {
  String? getAudioName(String path, Map<String, String> originalMap) {
    Map<String, String> reverseMap =
        originalMap.map((key, value) => MapEntry(value, key));
    return reverseMap[path];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      contentPadding: const EdgeInsets.all(12),
      content: SingleChildScrollView(
        child: Column(
          children: widget.audioMap.keys.toList().map((topic) {
            return ListTile(
              tileColor: Theme.of(context).colorScheme.surface,
              dense: true,
              title: Text(
                topic,
                style: const TextStyle(fontSize: 15),
              ),
              onTap: () {
                widget.controller.text = widget.audioMap[topic]!;
                widget.onTap(widget.audioMap[topic]!);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
