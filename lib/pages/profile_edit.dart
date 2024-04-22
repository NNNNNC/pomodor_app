import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pomodoro_app/utils/custom_box.dart';

class profile_edit extends StatefulWidget {
  const profile_edit({Key? key}) : super(key: key);
  @override
  State<profile_edit> createState() => _profile_editState();
}

class _profile_editState extends State<profile_edit> {
  String? selectedAudioPath;
  final Map<String, String> audioItems = {
    'audios/Dryer.mp3': 'Dryer',
    'audios/Fan.mp3': 'Fan',
    'audios/Rain.mp3': 'Rain',
    'audios/Train.mp3': 'Train',
    'audios/Waves.mp3': 'Waves',
  };

  final player = AudioPlayer();

  Future<void> playSound(String audioPath) async{
    await player.play(AssetSource(audioPath));
  }

  TextEditingController _nameController = TextEditingController();
  TextEditingController _focusController = TextEditingController();
  TextEditingController _shortBreakController = TextEditingController();
  TextEditingController _longBreakController = TextEditingController();
  TextEditingController _WhiteNoiseController = TextEditingController();

  String? dropdownValue;
  List<String> items = [
    '10',
    '20',
    '30',
    '40',
    '50',
  ];

  @override
  void initState() {
    super.initState();
    dropdownValue;
    selectedAudioPath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile Edit"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.check,
                    size: 30,
                  )),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 15, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'PROFILE NAME',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: custom_box(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Name:',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(
                        width: 180,
                        child: TextField(
                          cursorColor: Color.fromRGBO(192, 192, 192, 1),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Color.fromRGBO(192, 192, 192, 1),
                            )),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(192, 192, 192, 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30, left: 10, bottom: 5),
                child: Row(
                  children: [
                    SizedBox(
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Focus Duration:',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(
                          child: Row(
                            children: [
                              SizedBox(child: customTextField(items)),
                              Text(' Minutes',
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 3.5),
                  child: custom_box(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Long Break Length:',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Row(
                          children: [
                            SizedBox(child: customTextField(items)),
                            Text(' Minutes',
                                style: Theme.of(context).textTheme.titleMedium),
                          ],
                        ),
                      ],
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 3.5),
                  child: custom_box(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Short Break Length:',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Row(
                          children: [
                            SizedBox(child: customTextField(items)),
                            Text(' Minutes',
                                style: Theme.of(context).textTheme.titleMedium),
                          ],
                        ),
                      ],
                    ),
                  )),
              Padding(
                padding: EdgeInsets.only(top: 45, left: 10, bottom: 5),
                child: Row(
                  children: [
                    SizedBox(
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
                  child: custom_box(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'White Noise:',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        DropdownButton<String>(
                          hint: Text('Select an audio'),
                          value: selectedAudioPath,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedAudioPath = newValue;
                              playSound(selectedAudioPath!);
                            });
                          },
                          items: audioItems.entries
                              .map<DropdownMenuItem<String>>((entry) {
                            return DropdownMenuItem<String>(
                              value: entry.key,
                              child: Text(entry.value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 3.5),
                  child: custom_box(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ringtone:',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        customTextField(items)
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }

  Widget customTextField(List<String> items) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (item) {
        setState(() {
          dropdownValue = item;
        });
      },
    );
  }
}
