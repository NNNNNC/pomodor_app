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
  List<Map<String, dynamic>> settings = [
    {
      'profile_name': 'Profile Name',
      'focus_duration': 25,
      'long_break': 20,
      'short_break': 15,
      'white_noise': 'Rain',
      'ringtone': 'Disney',
    },
    {
      'profile_name': 'Profile Name 2',
      'focus_duration': 30,
      'long_break': 25,
      'short_break': 10,
      'white_noise': 'Ocean',
      'ringtone': 'Classical',
    },
  ];

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
                'Profile Name',
                25,
                20,
                15,
                'audios/Rain.mp3',
                'Disney',));
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
