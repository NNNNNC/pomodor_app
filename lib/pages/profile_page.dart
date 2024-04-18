import 'package:flutter/material.dart';
import 'package:pomodoro_app/utils/profile_tile.dart';

class profile_page extends StatefulWidget {
  const profile_page({super.key});

  @override
  State<profile_page> createState() => _profile_pageState();
}

class _profile_pageState extends State<profile_page> {
  List<Widget> profileTiles = [];

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
              profileTiles.add(
                profile_tile(
                  profile_name: 'Profile',
                  focus_duration: 25,
                  long_break: 20,
                  short_break: 15,
                  white_noise: 'Rain',
                  ringtone: 'Disney',
                ),
              );
            });
          },
          child: Icon(
            Icons.add,
            size: 45,
          ),
        ),
        body: ListView.builder(
          itemCount: profileTiles.length,
          itemBuilder: (context, index) {
            return profileTiles[index];
          },
        ));
  }
}
