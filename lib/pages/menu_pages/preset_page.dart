import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pomodoro_app/main.dart';
import 'package:pomodoro_app/models/profileModel.dart';
import 'package:pomodoro_app/utils/audio_dialog.dart';
import 'package:pomodoro_app/utils/custom_box.dart';

class PresetPage extends StatefulWidget {
  const PresetPage({super.key});

  @override
  State<PresetPage> createState() => _PresetPageState();
}

class _PresetPageState extends State<PresetPage> {
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

  late TextEditingController _focusController;
  late TextEditingController _shortBreakController;
  late TextEditingController _longBreakController;
  late TextEditingController _whiteNoiseController;
  late TextEditingController _ringtoneController;
  late profileModel profile;
  @override
  void initState() {
    super.initState();
    // Initialize TextEditingControllers with default values
    _focusController = TextEditingController();
    _shortBreakController = TextEditingController();
    _longBreakController = TextEditingController();
    _whiteNoiseController = TextEditingController();
    _ringtoneController = TextEditingController();

    // Open the box
    Hive.openBox<profileModel>('profile').then((box) {
      setState(() {
        profileBox = box; // Assign the opened box to your variable.
        // Load the profile or create a new one if it doesn't exist
        if (profileBox.isEmpty) {
          profile = profileModel(
              "preset", 25, 5, 10, 'audio/Rain.mp3', 'audio/ringtone_1.mp3');
          profileBox.add(profile);
           // Set the created profile as the default key's selectedProfile
        if (defaultKey.isNotEmpty) { // Ensure defaultKey has at least one item
          defaultKey.get(0)?.selectedProfile = profile.key; // Set the selected profile
        }
        } else {
          profile = profileBox.getAt(0)!; // Load the first profile
        }

        
        // Set the controllers' text values after loading the profile
        _focusController.text = profile.focusDuration.toString();
        _shortBreakController.text = profile.shortBreak.toString();
        _longBreakController.text = profile.longBreak.toString();
        _whiteNoiseController.text = profile.whiteNoise;
        _ringtoneController.text = profile.ringtone;
      });
    }).catchError((error) {
      // Handle error if box fails to open
      print('Failed to open the box: $error');
    });
  }

  @override
  void dispose() {
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
          title: Text(
            "Presets",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: IconButton(
                  onPressed: () {
                    // Update the profile
                    profile.focusDuration = int.parse(_focusController.text);
                    profile.shortBreak = int.parse(_shortBreakController.text);
                    profile.longBreak = int.parse(_longBreakController.text);
                    profile.whiteNoise = _whiteNoiseController.text;
                    profile.ringtone = _ringtoneController.text;

                    // Save the profile to Hive
                    profileBox.putAt(0, profile);
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
                        style: Theme.of(context).textTheme.bodySmall,
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
                            style: Theme.of(context).textTheme.titleMedium,
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
                                      });
                                    },
                                  ),
                                ),
                                Text(' Minutes',
                                    style:
                                        Theme.of(context).textTheme.titleSmall),
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
                            style: Theme.of(context).textTheme.titleMedium,
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
                                    });
                                  },
                                ),
                              ),
                              Text(' Minutes',
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
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
                              style: Theme.of(context).textTheme.titleMedium,
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
                                      });
                                    },
                                  ),
                                ),
                                Text(' Minutes',
                                    style:
                                        Theme.of(context).textTheme.titleSmall),
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
                        style: Theme.of(context).textTheme.bodySmall,
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
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
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
                                        Theme.of(context).textTheme.titleMedium,
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
      icon: Icon(
        Icons.keyboard_arrow_down,
        size: 20,
      ),
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(
            item,
            style: Theme.of(context).textTheme.titleSmall,
          ),
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
