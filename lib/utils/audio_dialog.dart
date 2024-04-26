import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class audioDialog extends StatefulWidget {
  final Map<String, String> audioMap;
  final TextEditingController controller;
  final Function(String) onAudioSelected;

  const audioDialog(
      {super.key, required this.audioMap, required this.controller, required this.onAudioSelected});

  @override
  State<audioDialog> createState() => _audioDialogState();
}

class _audioDialogState extends State<audioDialog> {
  late String _selectedItem;
  final player = AudioPlayer(); // Create an AudioPlayer instance

  // play audio method
  Future<void> playSound(String filepath) async {
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
      contentPadding: const EdgeInsets.only(left: 10.0, top: 18.0),
      title: Text(
        'Select Topic',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: SingleChildScrollView(
        child: Column(
          children: widget.audioMap.keys.toList().map((topic) {
            return RadioListTile(
              title: Text(
                topic,
                style: const TextStyle(fontSize: 16),
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
            widget.onAudioSelected(widget.audioMap[_selectedItem]!);
            // Stop audio when dialog closes
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
