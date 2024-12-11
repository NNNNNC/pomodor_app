import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pomodoro_app/main.dart';
import 'package:pomodoro_app/models/selectedModel.dart';
import 'package:pomodoro_app/pages/menu_pages/preset_add.dart';
import 'package:pomodoro_app/user_manual/profileManual_display.dart';
import 'package:pomodoro_app/utils/widgets/tiles/profile_tile.dart';

class PresetPage extends StatefulWidget {
  const PresetPage({super.key});

  @override
  State<PresetPage> createState() => _PresetPageState();
}

class _PresetPageState extends State<PresetPage> {
  void updateProfile(
    int index,
    String newName,
    int newFocusDuration,
    int newShortBreak,
    int newLongBreak,
    String newWhiteNoise,
    String newRingtone,
    int newCounter,
  ) {
    setState(() {
      var profile = profileBox.getAt(index);
      profile!.name = newName;
      profile.focusDuration = newFocusDuration;
      profile.shortBreak = newShortBreak;
      profile.longBreak = newLongBreak;
      profile.whiteNoise = newWhiteNoise;
      profile.ringtone = newRingtone;
      profile.pomodoroCounter = newCounter;
      profileBox.putAt(index, profile);
    });
  }

  void onSelect(int index) {
    setState(() {
      var topic = defaultKey.get(0)?.selectedTopic;
      if (defaultKey.get(0)?.selectedProfile == profileBox.getAt(index)!.key) {
        defaultKey.put(
          0,
          SelectedModel(selectedProfile: null, selectedTopic: topic),
        );
      } else {
        defaultKey.put(
          0,
          SelectedModel(
            selectedProfile: profileBox.getAt(index)!.key,
            selectedTopic: topic,
          ),
        );
      }
    });
  }

  late TextEditingController _nameController;

  // void createNewTopic() {
  //   setState(() {
  //     profileBox.add(profileModel(
  //       _nameController.text,
  //       25,
  //       5,
  //       15,
  //       'audio/Rain.mp3',
  //       'audio/ringtone_1.mp3',
  //       3,
  //     ));
  //     _nameController.clear();
  //   });
  //   Navigator.of(context).pop();
  // }

  @override
  void initState() {
    _nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: const Text(
            "Presets",
            style: TextStyle(
              fontSize: 18.5,
            ),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(
                Icons.info_outline_rounded,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => profileManualDisplay()),
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding:
                  const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
              itemCount: profileBox.length,
              itemBuilder: (context, index) {
                var profile = profileBox.getAt(index);
                return profile_tile(
                  profile_name: profile!.name,
                  focus_duration: profile.focusDuration,
                  long_break: profile.longBreak,
                  short_break: profile.shortBreak,
                  white_noise: profile.whiteNoise,
                  ringtone: profile.ringtone,
                  counter: profile.pomodoroCounter,
                  onDelete: () {
                    setState(() {
                      profileBox.deleteAt(index);
                    });
                  },
                  onSelect: onSelect,
                  profileIndex: index,
                  onUpdate: (newName, newFocusDuration, newLongBreak,
                      newShortBreak, newWhiteNoise, newRingtone, newCounter) {
                    updateProfile(
                      index,
                      newName,
                      newFocusDuration,
                      newShortBreak,
                      newLongBreak,
                      newWhiteNoise,
                      newRingtone,
                      newCounter,
                    );
                  },
                );
              },
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 92.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(25),
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PresetAdd()),
                  ).then((value) => setState(() {}));
                },
                child: Ink(
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1.5,
                        spreadRadius: 0,
                        offset: const Offset(0, 2),
                        color: Colors.black.withOpacity(0.25),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_circle),
                          SizedBox(width: 10),
                          Text(
                            'Add a preset',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
