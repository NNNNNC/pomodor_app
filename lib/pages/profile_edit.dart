import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pomodoro_app/main.dart';
import 'package:pomodoro_app/models/profileModel.dart';
import 'package:pomodoro_app/utils/audio_dialog.dart';
import 'package:pomodoro_app/utils/custom_box.dart';

class profile_edit extends StatefulWidget {
  final int profileIndex;
  final Function(String, int, int, int, String, String) onUpdate;

  const profile_edit(
      {Key? key, required this.profileIndex, required this.onUpdate})
      : super(key: key);
  @override
  State<profile_edit> createState() => _profile_editState();
}

class _profile_editState extends State<profile_edit> {
  void _updateProfile() {
    widget.onUpdate(profile.name, profile.focusDuration, profile.longBreak,
        profile.shortBreak, profile.whiteNoise, profile.ringtone);
  }

  final Map<String, String> ringtoneMap = {
    'Ringtone 1': 'audio/ringtone_1.mp3',
    'Ringtone 2': 'audio/ringtone_2.mp3',
    'Ringtone 3': 'audio/ringtone_3.mp3',
    'Ringtone 4': 'audio/ringtone_4.mp3',
    'Ringtone 5': 'audio/ringtone_5.mp3',
    // Add more entries for other audio files
  };

  final Map<String, String> whiteNoiseMap = {
    'Dryer': 'audio/Dryer.mp3',
    'Fan': 'audio/Fan.mp3',
    'Rain': 'audio/Rain.mp3',
    'Train': 'audio/Train.mp3',
    'Waves': 'audio/Waves.mp3',
    // Add more entries for other audio files
  };

  String? getAudioName(String path, Map<String, String> originalMap) {
    Map<String, String> reverseMap =
        originalMap.map((key, value) => MapEntry(value, key));
    return reverseMap[path];
  }

  late TextEditingController _nameController;
  late TextEditingController _focusController;
  late TextEditingController _shortBreakController;
  late TextEditingController _longBreakController;
  late TextEditingController _whiteNoiseController;
  late TextEditingController _ringtoneController;
  late profileModel profile;
  @override
  void initState() {
    super.initState();
    profile = profileBox.getAt(widget.profileIndex)!;
    _nameController = TextEditingController(text: profile.name);
    _focusController =
        TextEditingController(text: profile.focusDuration.toString());
    _shortBreakController =
        TextEditingController(text: profile.shortBreak.toString());
    _longBreakController =
        TextEditingController(text: profile.longBreak.toString());
    _whiteNoiseController = TextEditingController(text: profile.whiteNoise);
    _ringtoneController = TextEditingController(text: profile.ringtone);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _focusController.dispose();
    _shortBreakController.dispose();
    _longBreakController.dispose();
    _whiteNoiseController.dispose();
    _ringtoneController.dispose();
    super.dispose();
  }

  bool selectAudio = false;
  bool selectRingtone = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextField(
            cursorColor: Colors.white,
            controller: _nameController,
            style: Theme.of(context).textTheme.titleLarge,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: IconButton(
                  onPressed: () {
                    profile.name = _nameController.text;
                    _updateProfile();
                    profile.save();
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.check,
                    size: 30,
                  )),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(3.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 10, bottom: 5),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'TIMER',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: custom_box(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Focus Duration :',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(
                            child: Row(
                              children: [
                                SizedBox(
                                  child: customTextField(
                                    items: ['5', '10', '15', '20', '25', '30'],
                                    controller: _focusController,
                                    onChanged: (value) {
                                      setState(() {
                                        profile.focusDuration =
                                            int.parse(value!);
                                        _updateProfile();
                                      });
                                    },
                                  ),
                                ),
                                Text(' Minutes',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 3.5),
                  child: custom_box(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Long Break Length :',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                child: customTextField(
                                  items: ['5', '10', '15', '20', '25', '30'],
                                  controller: _longBreakController,
                                  onChanged: (value) {
                                    setState(() {
                                      profile.longBreak = int.parse(value!);
                                      _updateProfile();
                                    });
                                  },
                                ),
                              ),
                              Text(' Minutes',
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5.0),
                Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 3.5),
                    child: custom_box(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Short Break Length :',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  child: customTextField(
                                    items: ['5', '10', '15', '20', '25', '30'],
                                    controller: _shortBreakController,
                                    onChanged: (value) {
                                      setState(() {
                                        profile.shortBreak = int.parse(value!);
                                        _updateProfile();
                                      });
                                    },
                                  ),
                                ),
                                Text(' Minutes',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 45, left: 10, bottom: 5),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'SOUND',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 3.5),
                  child: GestureDetector(
                    onTap: () {
                      selectAudio = true;
                      showDialog<String>(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) => audioDialog(
                          audioMap: whiteNoiseMap,
                          controller: _whiteNoiseController,
                          whiteNoise: selectAudio,
                          ringTone: selectRingtone,
                          onAudioSelected: (selectedValue) {
                            Navigator.of(context).pop(selectedValue);
                          },
                        ),
                      ).then((selectedValue) {
                        setState(() {
                          selectAudio = false;
                          _whiteNoiseController.text = selectedValue!;
                          profile.whiteNoise = _whiteNoiseController.text;
                          _updateProfile();
                        });
                      });
                    },
                    child: custom_box(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'White Noise',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                    getAudioName(_whiteNoiseController.text,
                                        whiteNoiseMap)!,
                                    style:
                                        Theme.of(context).textTheme.bodySmall)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5.0),
                Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                      left: 10,
                      top: 3.5,
                      bottom: 8.0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        selectRingtone = true;
                        showDialog<String>(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) => audioDialog(
                            whiteNoise: selectAudio,
                            ringTone: selectRingtone,
                            audioMap: ringtoneMap,
                            controller: _ringtoneController,
                            onAudioSelected: (selectedValue) {
                              selectRingtone = false;
                              Navigator.of(context).pop(selectedValue);
                            },
                          ),
                        ).then((selectedValue) {
                          setState(() {
                            _ringtoneController.text = selectedValue!;
                            profile.ringtone = _ringtoneController.text;
                            _updateProfile();
                          });
                        });
                      },
                      child: custom_box(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Ringtone',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    getAudioName(
                                        _ringtoneController.text, ringtoneMap)!,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ));
  }

  Widget customTextField({
    required List<String> items,
    required TextEditingController controller,
    required Function(String?) onChanged,
  }) {
    String? selectedValue =
        items.contains(controller.text) ? controller.text : null;
    return DropdownButton<String>(
      value: selectedValue,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (value) {
        onChanged(value!);
        // Updadate controller value
        controller.text = value;
      },
    );
  }
}
