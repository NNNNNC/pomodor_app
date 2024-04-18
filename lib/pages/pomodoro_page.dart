import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pomodoro_app/utils/topic_dialog.dart';

class PomodoroPage extends StatefulWidget {
  const PomodoroPage({super.key});
  @override
  State<PomodoroPage> createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> {
  bool isFocusing = false;
  bool isBreak = false;
  bool isLongBreak = false;
  bool timerStarted = false;
  Timer? timer;
  int seconds = 0, minutes = 0;
  String digitSec = '00', digitMin = '00';
  List laps = [];

  // timer methods

  void timerStop() {
    timer!.cancel();
    setState(() {
      timerStarted = false;
    });
  }

  void reset() {
    timer!.cancel();
    setState(() {
      seconds = 59;
      minutes = 25;
      digitMin = '25';
      digitSec = '00';
      timerStarted = false;
    });
  }

  void addLaps() {
    String lap = "$digitMin:$digitSec";
    setState(() {
      laps.add(lap);
    });
  }

  void startTimer() {
    timerStarted = true;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int localSeconds = seconds - 1;
      int localMinutes = minutes;

      if (localSeconds < 1) {
        localMinutes--;
        localSeconds = 59;
      }
      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        digitSec = (seconds >= 10) ? "$seconds" : "0$seconds";
        digitMin = (seconds >= 10) ? "$minutes" : "0$minutes";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pomodoro"),
      ),

      // Select topic and headphones
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) {
                      return const TopicDialog();
                    },
                  ),
                  child: Text(
                    'SELECT TOPIC',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => showMenu(
                    context: context,
                    position:
                        const RelativeRect.fromLTRB(270.0, 140.0, 300.0, 150.0),
                    items: const [
                      PopupMenuItem(
                        child: Text('No Sound'),
                      ),
                      PopupMenuItem(
                        child: Text('Rain'),
                      ),
                      PopupMenuItem(
                        child: Text('TV Static'),
                      ),
                      PopupMenuItem(
                        child: Text('Fan'),
                      ),
                    ],
                  ),
                  icon: Icon(
                    Icons.headphones,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 36,
          ),

          // states
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Focus state
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isFocusing = !isFocusing;
                      isBreak = false;
                      isLongBreak = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isFocusing ? Colors.grey[900] : Colors.grey,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(77),
                        bottomLeft: Radius.circular(77),
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 1.5,
                          spreadRadius: 0,
                          offset: const Offset(-4, 4),
                          color: Colors.black.withOpacity(0.25),
                        ),
                      ],
                    ),
                    height: 32,
                    width: 71,
                    child: const Center(
                      child: Text(
                        'Focus',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                // Long Break State
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLongBreak = !isLongBreak;
                      isBreak = false;
                      isFocusing = false;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 5.0),
                    decoration: BoxDecoration(
                      color: isLongBreak ? Colors.grey[900] : Colors.grey,
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 1.5,
                          spreadRadius: 0,
                          offset: const Offset(0, 4),
                          color: Colors.black.withOpacity(0.25),
                        ),
                      ],
                    ),
                    height: 32,
                    width: 90,
                    child: const Center(
                      child: Text(
                        'Long Break',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                // Short break state
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLongBreak = false;
                      isBreak = !isBreak;
                      isFocusing = false;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 5.0),
                    decoration: BoxDecoration(
                      color: isBreak ? Colors.grey[900] : Colors.grey,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                        topRight: Radius.circular(77),
                        bottomRight: Radius.circular(77),
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 1.5,
                          spreadRadius: 0,
                          offset: const Offset(4, 4),
                          color: Colors.black.withOpacity(0.25),
                        ),
                      ],
                    ),
                    height: 32,
                    width: 71,
                    child: const Center(
                      child: Text(
                        'Break',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 72,
          ),

          // Focus Button
          GestureDetector(
            onTap: () {
              setState(() {
                isFocusing = !isFocusing;
                isBreak = false;
                isLongBreak = false;
              });
            },
            child: Container(
              width: 251,
              height: 251,
              decoration: BoxDecoration(
                color: isFocusing == true
                    ? const Color(0xffc50e0e)
                    : isBreak == true
                        ? const Color(0xff1dc50e)
                        : isLongBreak == true
                            ? const Color(0xff0e15c5)
                            : const Color(0xff3a3939),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1.5,
                    spreadRadius: 7,
                    offset: Offset.zero,
                    color: Colors.black.withOpacity(0.25),
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      isFocusing
                          ? 'FOCUSING'
                          : isBreak
                              ? 'BREAK'
                              : isLongBreak
                                  ? 'LONG BREAK'
                                  : 'FOCUS',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      isFocusing
                          ? '25:00'
                          : isBreak
                              ? '05:00'
                              : isLongBreak
                                  ? '15:00'
                                  : 'Click here to start pomodoro',
                      style: const TextStyle(
                        color: Color(0xffc0c0c0),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
