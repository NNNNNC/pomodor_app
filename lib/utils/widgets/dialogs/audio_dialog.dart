import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:pomodoro_app/utils/data_init/audiomaps.dart';

class audioDialog extends StatefulWidget {
  final bool whiteNoise;
  final bool ringTone;
  final Map<String, String> audioMap;
  final TextEditingController controller;
  final Function(String) onAudioSelected;

  const audioDialog({
    super.key,
    required this.audioMap,
    required this.controller,
    required this.onAudioSelected,
    required this.whiteNoise,
    required this.ringTone,
  });

  @override
  State<audioDialog> createState() => _audioDialogState();
}

class _audioDialogState extends State<audioDialog> {
  String? getAudioName(String path, Map<String, String> originalMap) {
    Map<String, String> reverseMap =
        originalMap.map((key, value) => MapEntry(value, key));
    return reverseMap[path];
  }

  late String _selectedItem;
  final player = AudioPlayer();

  // play audio method
  Future<void> playSound(String filepath) async {
    await player.play(AssetSource(filepath));
  }

  @override
  void initState() {
    super.initState();

    Map<String, String> audioMap = {};
    audioMap.addAll(Ringtones().ringToneMap);
    audioMap.addAll(WhiteNoise().whiteNoiseMap);

    _selectedItem = getAudioName(
      widget.controller.text,
      audioMap,
    )!;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      contentPadding: const EdgeInsets.only(top: 18.0),
      title: Text(
        widget.whiteNoise
            ? 'Select White Noise'
            : widget.ringTone
                ? 'Select Ringtone'
                : 'Select Audio',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: SingleChildScrollView(
        child: Column(
          children: widget.audioMap.keys.toList().map((topic) {
            return RadioListTile(
              tileColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              dense: true,
              title: Text(
                topic,
                style: const TextStyle(fontSize: 15),
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
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
