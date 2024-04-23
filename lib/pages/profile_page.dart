import 'package:flutter/material.dart';
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
              settings.add({
                'profile_name': 'Profile Name',
                'focus_duration': 25,
                'long_break': 20,
                'short_break': 15,
                'white_noise': 'Rain',
                'ringtone': 'Disney',
              });
            });
          },
          child: Icon(
            Icons.add,
            size: 45,
          ),
        ),
        body: ListView.builder(
          itemCount: settings.length,
          itemBuilder: (context, index) {
            final profile = settings[index];
            return profile_tile(
                profile_name: profile['profile_name'],
                focus_duration: profile['focust_duration'] ?? 25,
                long_break: profile['long_break'] ?? 20,
                short_break: profile['short_break'] ?? 15,
                white_noise: profile['white_noise'],
                ringtone: profile['ringtone']);
          },
        ));
  }
}
