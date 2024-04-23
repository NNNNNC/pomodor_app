import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pomodoro_app/providers/visibility_provider.dart';
import 'package:pomodoro_app/utils/mini_task_tile.dart';
import 'package:pomodoro_app/utils/taskDialog.dart';
import 'package:pomodoro_app/utils/topic_dialog.dart';
import 'package:provider/provider.dart';

class PomodoroPage extends StatefulWidget {
  const PomodoroPage({
    super.key,
  });
  @override
  State<PomodoroPage> createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> {
  bool isMuted = false;
  bool isFocusing = false;
  bool isBreak = false;
  bool isLongBreak = false;
  bool timerStarted = false;
  Timer? timer;
  int seconds = 0, minutes = 0;
  int breakCounter = 0;
  int setMinute = 0;
  String digitSec = '00';
  String digitMin = '00';

  List tasks = [
    ['Do chapter 1', false],
    ['Memorize periodic table', false],
    ['Catch fish', false],
    ['Watch movie', false],
    ['Make lemonade', false],
    ['Drink coffee', true],
  ];

  void _taskStatusChange(bool? value, int index) {
    setState(() {
      tasks[index][1] = !tasks[index][1];
    });
  }

  // timer methods

  void timerStop() {
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      digitMin = '00';
      digitSec = '00';

      timerStarted = false;

      // transition to other states
      transition();
    });
  }

  void startTimer() {
    minutes = setMinute;
    timerStarted = true;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds == 0) {
          minutes--;
          seconds = 60;
        }
        seconds--;

        digitSec = (seconds >= 10) ? "$seconds" : "0$seconds";
        digitMin = (minutes >= 10) ? "$minutes" : "0$minutes";

        // stop if countdown is finished
        if ((minutes == 0) && (seconds == 0)) {
          timerStop();
        }
      });
    });
  }

  // focus methods

  void focus() {
    final visibility = context.read<BottomBarVisibility>();

    setState(() {
      isFocusing = !isFocusing;
      isBreak = false;
      isLongBreak = false;

      visibility.toggleVisibility(!isFocusing);

      setMinute = 25;
      digitMin = (setMinute >= 10) ? "$setMinute" : "0$setMinute";

      if (timerStarted) {
        timerStop();
      } else {
        startTimer();
      }
    });
  }

  void shortBreak() {
    final visibility = context.read<BottomBarVisibility>();

    setState(() {
      isFocusing = false;
      isBreak = !isBreak;
      isLongBreak = false;

      visibility.toggleVisibility(true);

      setMinute = 5;
      digitMin = (setMinute >= 10) ? "$setMinute" : "0$setMinute";

      if (timerStarted) {
        timerStop();
      } else {
        startTimer();
      }
    });
  }

  void longBreak() {
    final visibility = context.read<BottomBarVisibility>();

    setState(() {
      isFocusing = false;
      isBreak = false;
      isLongBreak = !isLongBreak;

      visibility.toggleVisibility(true);

      setMinute = 15;
      digitMin = (setMinute >= 10) ? "$setMinute" : "0$setMinute";

      if (timerStarted) {
        timerStop();
      } else {
        startTimer();
      }
    });
  }

  void transition() {
    setState(() {
      if (isFocusing) {
        isFocusing = false;

        if (breakCounter <= 3) {
          shortBreak();
        } else {
          longBreak();
          breakCounter = 0;
        }
      } else if (isBreak) {
        isBreak = false;
        focus();
        breakCounter++;
      } else if (isLongBreak) {
        isLongBreak = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final int totalDuration = isFocusing ? 25 : (isBreak ? 5 : 15);
    final double progress =
        (totalDuration * 60 - (seconds + minutes * 60)) / (totalDuration * 60);
    return Consumer<BottomBarVisibility>(
      builder: (context, value, child) => Scaffold(
        appBar: value.isVisible
            ? AppBar(
                title: const Text("Pomodoro"),
              )
            : const PreferredSize(
                preferredSize: Size.fromHeight(100.0),
                child: SizedBox(height: 60.0),
              ),

        // Select topic and headphones
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                      // onPressed: () => showMenu(
                      //   context: context,
                      //   position: const RelativeRect.fromLTRB(
                      //       270.0, 140.0, 300.0, 150.0),
                      //   items: const [
                      //     PopupMenuItem(
                      //       child: Text('No Sound'),
                      //     ),
                      //     PopupMenuItem(
                      //       child: Text('Rain'),
                      //     ),
                      //     PopupMenuItem(
                      //       child: Text('TV Static'),
                      //     ),
                      //     PopupMenuItem(
                      //       child: Text('Fan'),
                      //     ),
                      //   ],
                      // ),
                      onPressed: () {
                        setState(() {
                          isMuted = !isMuted;
                        });
                      },
                      icon: Icon(
                        isMuted ? Icons.headset_off : Icons.headphones,
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
                      onTap: () => focus(),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
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
                      onTap: () => longBreak(),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.only(left: 5.0),
                        decoration: BoxDecoration(
                          color: isLongBreak ? Colors.grey[900] : Colors.grey,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
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
                      onTap: () => shortBreak(),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
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
              Stack(
                children: [
                  // progress indicator
                  Positioned.fill(
                    child: CircularProgressIndicator(
                      value: progress,
                      backgroundColor: isBreak
                          ? const Color(0xff1dc50e)
                          : isLongBreak
                              ? const Color(0xff0e15c5)
                              : Colors.transparent,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isFocusing
                            ? const Color(0xff1dc50e)
                            : isBreak
                                ? const Color(0xff252525)
                                : isLongBreak
                                    ? const Color(0xff252525)
                                    : Colors.transparent,
                      ),
                      strokeWidth: 10,
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => focus(),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 700),
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
                                shadows: CupertinoContextMenu.kEndBoxShadow,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              isFocusing || isBreak || isLongBreak
                                  ? '$digitMin:$digitSec'
                                  : 'Click here to start Pomodoro',
                              style: const TextStyle(
                                color: Color(0xffc0c0c0),
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32.0),

              // lock toggle
              if (isFocusing && value.isVisible)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          value.toggleVisibility(false);
                        });
                      },
                      icon: Icon(
                        Icons.lock,
                        size: 28,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ),

              // will only show on focus mode
              // tasks
              if (value.isVisible == false)
                Expanded(
                  child: Container(
                    width: 330,
                    height: 180,
                    decoration: BoxDecoration(
                      color: const Color(0xff3a3939),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 1.5,
                          spreadRadius: 1,
                          offset: const Offset(0, 4),
                          color: Colors.black.withOpacity(0.25),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 12.0, right: 1.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tasks',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const TaskDialog();
                                    },
                                  );
                                },
                                icon: Icon(
                                  Icons.fullscreen,
                                  size: 24,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: SizedBox(
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: tasks.length,
                                itemBuilder: (context, index) {
                                  return MiniTaskTile(
                                    taskTitle: tasks[index][0],
                                    isChecked: tasks[index][1],
                                    onChanged: (value) =>
                                        _taskStatusChange(value, index),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 24),

              // bottom icons
              if (value.isVisible == false)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.lock_open_outlined,
                              size: 32,
                              color: Colors.grey[850],
                            ),
                            onPressed: () {
                              setState(() {
                                value.toggleVisibility(!value.isVisible);
                              });
                            },
                          ),
                          Image.asset(
                            'assets/icons/document.png',
                            height: 40,
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.5),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
