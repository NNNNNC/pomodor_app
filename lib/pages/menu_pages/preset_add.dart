import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pomodoro_app/main.dart';
import 'package:pomodoro_app/models/profileModel.dart';
import 'package:pomodoro_app/utils/audio_dialog.dart';
import 'package:pomodoro_app/utils/custom_box.dart';

class PresetAdd extends StatefulWidget {
  const PresetAdd({
    Key? key,
  }) : super(key: key);
  @override
  State<PresetAdd> createState() => PresetAddState();
}

class PresetAddState extends State<PresetAdd> {
  final Map<String, String> ringtoneMap = {
    'Ringtone 1': 'audio/ringtone_1.mp3',
    'Ringtone 2': 'audio/ringtone_2.mp3',
    'Ringtone 3': 'audio/ringtone_3.mp3',
    'Ringtone 4': 'audio/ringtone_4.mp3',
    'Ringtone 5': 'audio/ringtone_5.mp3',
  };

  final Map<String, String> whiteNoiseMap = {
    'Dryer': 'audio/Dryer.mp3',
    'Fan': 'audio/Fan.mp3',
    'Rain': 'audio/Rain.mp3',
    'Train': 'audio/Train.mp3',
    'Waves': 'audio/Waves.mp3',
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
    _nameController = TextEditingController(text: 'New Preset');
    _focusController = TextEditingController(text: '25');
    _shortBreakController = TextEditingController(text: '5');
    _longBreakController = TextEditingController(text: '15');
    _whiteNoiseController = TextEditingController(text: 'audio/Dryer.mp3');
    _ringtoneController = TextEditingController(text: 'audio/ringtone_1.mp3');
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
              child: TextButton(
                onPressed: () {
                  profileBox.add(
                    profileModel(
                      _nameController.text,
                      int.parse(_focusController.text),
                      int.parse(_shortBreakController.text),
                      int.parse(_longBreakController.text),
                      _whiteNoiseController.text,
                      _ringtoneController.text,
                    ),
                  );

                  Navigator.pop(context);
                },
                child: Text(
                  'Add',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
                                    items: [
                                      '5',
                                      '10',
                                      '15',
                                      '20',
                                      '25',
                                      '30',
                                      '35',
                                      '40',
                                      '50',
                                      '55',
                                      '60'
                                    ],
                                    controller: _focusController,
                                    onChanged: (value) {
                                      setState(() {
                                        _focusController.text = value!;
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
                                  items: [
                                    '5',
                                    '10',
                                    '15',
                                    '20',
                                    '25',
                                    '30',
                                    '35',
                                    '40',
                                    '50',
                                    '55',
                                    '60'
                                  ],
                                  controller: _longBreakController,
                                  onChanged: (value) {
                                    setState(() {
                                      _longBreakController.text = value!;
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
                                        _shortBreakController.text = value!;
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
                        setState(() {});
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
                          setState(() {});
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

    return Container(
      margin: EdgeInsets.only(right: 8.0),
      constraints: const BoxConstraints(maxWidth: 80),
      child: DropdownButtonFormField2(
        value: selectedValue,
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            onChanged(value);
            controller.text = value;
          }
        },
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).colorScheme.background,
          ),
          maxHeight: 200,
        ),
        isExpanded: false,
      ),
    );
  }
}
