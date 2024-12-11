import 'package:flutter/material.dart';
import 'package:pomodoro_app/main.dart';
import 'package:pomodoro_app/models/profileModel.dart';
import 'package:pomodoro_app/models/selectedModel.dart';
import 'package:pomodoro_app/user_manual/profileManual_display.dart';
import 'package:pomodoro_app/utils/widgets/dialogs/add_tile_dialog.dart';
import 'package:pomodoro_app/utils/widgets/tiles/profile_tile.dart';

class profile_page extends StatefulWidget {
  const profile_page({super.key});

  @override
  State<profile_page> createState() => _profile_pageState();
}

class _profile_pageState extends State<profile_page> {
  void updateProfile(
    int index,
    String newName,
    int newFocusDuration,
    int newShortBreak,
    int newLongBreak,
    String newWhiteNoise,
    String newRingtone,
  ) {
    setState(() {
      var profile = profileBox.getAt(index);
      profile!.name = newName;
      profile.focusDuration = newFocusDuration;
      profile.shortBreak = newShortBreak;
      profile.longBreak = newLongBreak;
      profile.whiteNoise = newWhiteNoise;
      profile.ringtone = newRingtone;
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

  void createNewTopic() {
    setState(() {
      profileBox.add(profileModel(
        _nameController.text,
        25,
        5,
        15,
        'audio/Rain.mp3',
        'audio/ringtone_1.mp3',
      ));
      _nameController.clear();
    });
    Navigator.of(context).pop();
  }

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
              "Profiles",
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
        floatingActionButton: SizedBox(
          height: 50,
          width: 50,
          child: FloatingActionButton(
            heroTag: 'profile',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return add_tile_dialog(
                    controller: _nameController,
                    onPressed: createNewTopic,
                  );
                },
              );
            },
            child: const Icon(
              Icons.add,
              size: 45,
            ),
          ),
        ),
        body: ListView.builder(
          padding: EdgeInsets.only(bottom: 80),
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
              onDelete: () {
                setState(() {
                  profileBox.deleteAt(index);
                });
              },
              onSelect: onSelect,
              profileIndex: index,
              onUpdate: (newName, newFocusDuration, newLongBreak, newShortBreak,
                  newWhiteNoise, newRingtone) {
                updateProfile(index, newName, newFocusDuration, newShortBreak,
                    newLongBreak, newWhiteNoise, newRingtone);
              },
            );
          },
        ));
  }
}
