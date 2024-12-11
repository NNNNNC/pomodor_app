import 'package:flutter/material.dart';
import 'package:pomodoro_app/main.dart';
import 'package:pomodoro_app/pages/edit_pages/profile_edit.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

class profile_tile extends StatefulWidget {
  final String profile_name;
  final int focus_duration;
  final int long_break;
  final int short_break;
  final String white_noise;
  final String ringtone;
  final int profileIndex;
  final int counter;
  final VoidCallback onDelete;
  final Function(String, int, int, int, String, String, int) onUpdate;
  final Function(int) onSelect;

  const profile_tile({
    Key? key,
    required this.profile_name,
    required this.focus_duration,
    required this.long_break,
    required this.short_break,
    required this.white_noise,
    required this.ringtone,
    required this.onDelete,
    required this.profileIndex,
    required this.onUpdate,
    required this.onSelect,
    required this.counter,
  }) : super(key: key);

  @override
  State<profile_tile> createState() => _profile_tileState();
}

class _profile_tileState extends State<profile_tile> {
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

    bool isSelected = defaultKey.get(0)?.selectedProfile ==
        profileBox.getAt(widget.profileIndex)!.key;

    void toggleSwitch() {
      setState(() {
        isSelected = !isSelected;
        if (isSelected) {
          widget.onSelect(widget.profileIndex);
        }
      });
    }

    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 7, bottom: 5),
      child: GestureDetector(
        onTap: toggleSwitch,
        child: Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 20,
            top: (widget.profileIndex > 2) ? 10 : 20,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                blurRadius: 1.5,
                spreadRadius: 0,
                offset: const Offset(0, 2),
                color: Colors.black.withOpacity(0.25),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.profile_name,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                    width: 40,
                    child: AnimatedToggleSwitch.dual(
                      current: isSelected,
                      first: false,
                      second: true,
                      style: ToggleStyle(
                        borderColor: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1.5),
                          ),
                        ],
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12.0)),
                      ),
                      onChanged: (bool value) {
                        toggleSwitch();
                      },
                      styleBuilder: (value) => ToggleStyle(
                        indicatorColor: value ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                  if (widget.profileIndex > 2)
                    PopupMenuButton(
                      iconSize: 25,
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => profile_edit(
                                  profileIndex: widget.profileIndex,
                                  onUpdate: widget.onUpdate,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'Edit',
                            style: Theme.of(context).popupMenuTheme.textStyle,
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            widget.onDelete();
                          },
                          child: Text(
                            'Delete',
                            style: Theme.of(context).popupMenuTheme.textStyle,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              SizedBox(height: (widget.profileIndex > 2) ? 5 : 15),
              Row(
                children: [
                  SizedBox(
                    width: 180,
                    child: Text('Focus Duration :',
                        style: Theme.of(context).textTheme.labelMedium),
                  ),
                  Text('${widget.focus_duration} minutes',
                      style: Theme.of(context).textTheme.labelMedium),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  SizedBox(
                    width: 180,
                    child: Text('Short Break :',
                        style: Theme.of(context).textTheme.labelMedium),
                  ),
                  Text('${widget.short_break} minutes',
                      style: Theme.of(context).textTheme.labelMedium),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  SizedBox(
                    width: 180,
                    child: Text('Long Break :',
                        style: Theme.of(context).textTheme.labelMedium),
                  ),
                  Text('${widget.long_break} minutes',
                      style: Theme.of(context).textTheme.labelMedium),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  SizedBox(
                    width: 180,
                    child: Text('Long Break after :',
                        style: Theme.of(context).textTheme.labelMedium),
                  ),
                  Text('${widget.counter} pomodoro',
                      style: Theme.of(context).textTheme.labelMedium),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  SizedBox(
                    width: 180,
                    child: Text('White Noise :',
                        style: Theme.of(context).textTheme.labelMedium),
                  ),
                  Text(fileDisplayNames[widget.white_noise] ?? 'Not Selected',
                      style: Theme.of(context).textTheme.labelMedium),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  SizedBox(
                    width: 180,
                    child: Text('Ringtone :',
                        style: Theme.of(context).textTheme.labelMedium),
                  ),
                  Text(fileDisplayNames[widget.ringtone] ?? 'Not Selected',
                      style: Theme.of(context).textTheme.labelMedium),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
