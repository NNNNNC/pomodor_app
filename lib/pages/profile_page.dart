import 'package:flutter/material.dart';
import 'package:pomodoro_app/main.dart';
import 'package:pomodoro_app/models/profileModel.dart';
import 'package:pomodoro_app/utils/profile_tile.dart';

class profile_page extends StatefulWidget {
  const profile_page({super.key});

  @override
  State<profile_page> createState() => _profile_pageState();
}

class _profile_pageState extends State<profile_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'profile',
          onPressed: () {
            setState(() {
              profileBox.add(profileModel(
                'John Doe',
                25,
                5,
                15,
                'audio/Rain.mp3',
                'audio/ringtone_5.mp3',
              ));
            });
          },
          child: Icon(
            Icons.add,
            size: 45,
          ),
        ),
        body: ListView.builder(
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
              profileIndex: index,
            );
          },
        ));
  }
}
