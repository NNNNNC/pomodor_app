import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pomodoro_app/main.dart';
import 'package:pomodoro_app/models/profileModel.dart';
import 'package:pomodoro_app/utils/data_init/audiomaps.dart';
import 'package:pomodoro_app/utils/widgets/dialogs/audio_dialog.dart';
import 'package:pomodoro_app/utils/widgets/custom_box.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

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
                                        profile.focusDuration =
                                            int.parse(value!);
                                        _updateProfile();
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
                                      profile.longBreak = int.parse(value!);
                                      _updateProfile();
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
                                        _updateProfile();
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
                          audioMap: WhiteNoise().whiteNoiseMap,
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
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                    getAudioName(_whiteNoiseController.text,
                                        WhiteNoise().whiteNoiseMap)!,
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
                            audioMap: Ringtones().ringToneMap,
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
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    getAudioName(
                                      _ringtoneController.text,
                                      Ringtones().ringToneMap,
                                    )!,
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
