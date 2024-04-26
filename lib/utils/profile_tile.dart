import 'package:flutter/material.dart';
import 'package:pomodoro_app/pages/profile_edit.dart';
import 'package:pomodoro_app/utils/custom_box.dart';

class profile_tile extends StatelessWidget {
  final String profile_name;
  final int focus_duration;
  final int long_break;
  final int short_break;
  final String white_noise;
  final String ringtone;
  final int profileIndex;
  final VoidCallback onDelete;
  final Function(String, int,int,int) onUpdate;

  const profile_tile({
    Key? key,
    required this.profile_name,
    required this.focus_duration,
    required this.long_break,
    required this.short_break,
    required this.white_noise,
    required this.ringtone,
    required this.onDelete,
    required this.profileIndex, required this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, String> fileDisplayNames = {
      'audio/Dryer.mp3': 'Dryer',
      'audio/Fan.mp3': 'Fan',
      'audio/Rain.mp3': 'Rain',
      'audio/Train.mp3': 'Train',
      'audio/Waves.mp3': 'Waves',
      'audio/ringtone_1.mp3': 'Ringtone 1',
      'audio/ringtone_2.mp3': 'Ringtone 2',
      'audio/ringtone_3.mp3': 'Ringtone 3',
      'audio/ringtone_4.mp3': 'Ringtone 4',
      'audio/ringtone_5.mp3': 'Ringtone 5',
      // Add more mappings as needed
    };

    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 5),
      child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (Context) => profile_edit(
                      profileIndex: profileIndex,
                      onUpdate: onUpdate
                      )));
          },
          child: custom_box(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(profile_name,
                        style: Theme.of(context).textTheme.titleLarge),
                    PopupMenuButton(
                        color: Color.fromRGBO(48, 48, 48, 0.9),
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                  child: Text(
                                'Set Default',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                              PopupMenuItem(
                                  onTap: () {
                                    onDelete();
                                  },
                                  child: Text('Delete',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)))
                            ])
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text('Focus Duration :',
                        style: Theme.of(context).textTheme.titleMedium),
                    Padding(
                      padding: const EdgeInsets.only(left: 60),
                      child: Text(focus_duration.toString() + ' minutes',
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text('Long Break :',
                        style: Theme.of(context).textTheme.titleMedium),
                    Padding(
                      padding: const EdgeInsets.only(left: 90),
                      child: Text(long_break.toString() + ' minutes',
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text('Short Break :',
                        style: Theme.of(context).textTheme.titleMedium),
                    Padding(
                      padding: const EdgeInsets.only(left: 85),
                      child: Text(short_break.toString() + ' minutes',
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text('White Noise :',
                        style: Theme.of(context).textTheme.titleMedium),
                    Padding(
                      padding: const EdgeInsets.only(left: 82),
                      child: Text(fileDisplayNames[white_noise] ?? 'Not Selected',
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text('Ringtone :',
                        style: Theme.of(context).textTheme.titleMedium),
                    Padding(
                      padding: const EdgeInsets.only(left: 107),
                      child: Text(fileDisplayNames[ringtone] ?? 'Not Selected',
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
