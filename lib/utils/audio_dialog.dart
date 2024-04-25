import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class audioDialog extends StatefulWidget {

  final Map<String, String> audioMap;
  final TextEditingController controller;

  const audioDialog({super.key, required this.audioMap, required this.controller});

  @override
  State<audioDialog> createState() => _audioDialogState();
}

class _audioDialogState extends State<audioDialog> {

  late String _selectedItem;
  final player = AudioPlayer(); // Create an AudioPlayer instance

  // play audio method
  Future<void> playSound(String filepath) async{
    await player.play(AssetSource(filepath));
  }
  @override
  void initState() {
    super.initState();
    _selectedItem = widget.controller.text;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Topic', style: Theme.of(context).textTheme.titleLarge,),
      content: SingleChildScrollView(
        child: Column(
          children: widget.audioMap.keys.toList().map((topic) {
            return RadioListTile(
              title: Text(
                topic,
                style: TextStyle(fontSize: 16),
              ),
              value: topic,
              groupValue: _selectedItem,
              onChanged: (String? value) {
                setState(() {
                  _selectedItem = value!;
                  // Play audio when a new item is selected
                  playSound(widget.audioMap[value]!);
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
            Navigator.of(context).pop(_selectedItem);
            // Stop audio when dialog closes (optional)
            player.stop();
          },
          child: Text(
            'Save',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
