import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pomodoro_app/main.dart';
import 'package:pomodoro_app/providers/visibility_provider.dart';
import 'package:pomodoro_app/utils/flashcard_present.dart';
import 'package:pomodoro_app/utils/mini_task_tile.dart';
import 'package:pomodoro_app/utils/sliding_app_bar.dart';
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

class _PomodoroPageState extends State<PomodoroPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _slideController;
  int? topicKey;
  int? profileKey;
  String whiteNoise = '', ringTone = '';
  List<dynamic>? topicTasks;

  @override
  void initState() {
    topicKey = defaultKey.get(0)?.selectedTopic;
    profileKey = defaultKey.get(0)?.selectedProfile;
    topicTasks = topicBox.get(topicKey)?.tasks;
    whiteNoise = profileBox.get(profileKey)?.whiteNoise ?? 'audio/Dryer.mp3';
    ringTone = profileBox.get(profileKey)?.ringtone ?? 'audio/ringtone_1.mp3';

    super.initState();

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  bool isPlaying = false;
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
  final audioPlayer = AudioPlayer();

  void _taskStatusChange(bool? value, int index) {
    setState(() {
      topicTasks![index][1] = !topicTasks![index][1];
    });
  }

  void playSound(String filepath) async {
    await audioPlayer.play(
      AssetSource(filepath),
      mode: PlayerMode.lowLatency,
    );
  }

  void loop() async {
    await audioPlayer.setReleaseMode(ReleaseMode.loop);
  }

  void muteAudio() async {
    await audioPlayer.setVolume(0.0);
  }

  void unmuteAudio() async {
    await audioPlayer.setVolume(1.0);
  }

  void stopAudio() async {
    await audioPlayer.stop();
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

      visibility.toggleVisibility(!isBreak);

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

      visibility.toggleVisibility(!isLongBreak);

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

  List<String> getTopics() {
    List<String> topicList = [];
    topicList.add("None");

    if (topicBox.isNotEmpty) {
      for (int i = 0; i < topicBox.length; i++) {
        String topic = topicBox.getAt(i)!.name!;

        topicList.add(topic);
      }
    }
    return topicList;
  }

  @override
  Widget build(BuildContext context) {
    final int totalDuration = isFocusing ? 25 : (isBreak ? 5 : 15);
    final double progress =
        (totalDuration * 60 - (seconds + minutes * 60)) / (totalDuration * 60);
    return Consumer<BottomBarVisibility>(
      builder: (context, value, child) => Scaffold(
        appBar: SlidingAppBar(
          controller: _slideController,
          visible: value.isVisible,
          child: value.isVisible
              ? AppBar(
                  title: const Text("Pomodoro"),
                )
              : const PreferredSize(
                  preferredSize: Size.fromHeight(100.0),
                  child: SizedBox(height: 30.0),
                ),
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
                      onPressed: () async {
                        await showDialog<void>(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return const TopicDialog();
                          },
                        );
                        setState(() {
                          topicKey = defaultKey.get(0)?.selectedTopic;
                          topicTasks = topicBox.get(topicKey)?.tasks;
                        });
                      },
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
                      onPressed: () {
                        setState(() {
                          isMuted = !isMuted;
                          isMuted ? muteAudio() : unmuteAudio();
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
                    onTap: () {
                      setState(() {
                        isPlaying = !isPlaying;
                        isPlaying ? playSound(whiteNoise) : stopAudio();
                        loop();
                      });
                      isBreak
                          ? shortBreak()
                          : isLongBreak
                              ? longBreak()
                              : focus();
                    },
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
              if ((isFocusing || isBreak || isLongBreak) && value.isVisible)
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
              if (value.isVisible == false &&
                  (topicKey != null && topicTasks != null))
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
                              Row(
                                children: [
                                  Text(
                                    'Tasks',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                  Text(
                                    ' (${topicBox.get(topicKey)?.name})',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return TaskDialog(
                                        currentIndex: topicKey!,
                                      );
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
                                itemCount: topicTasks?.length,
                                itemBuilder: (context, index) {
                                  return MiniTaskTile(
                                    taskTitle: topicTasks![index][0],
                                    isChecked: topicTasks![index][1],
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

              if (value.isVisible == false &&
                  (topicKey == null || topicTasks == null))
                Expanded(
                  child: Center(
                    child: Text(
                      (topicKey == null)
                          ? 'Select a topic first to see your tasks.'
                          : 'Create tasks for more productivity!',
                      style: const TextStyle(fontSize: 16),
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
                              color: isBreak || isLongBreak
                                  ? Colors.grey[300]
                                  : Colors.grey[850],
                            ),
                            onPressed: () {
                              setState(() {
                                value.toggleVisibility(!value.isVisible);
                              });
                            },
                          ),
                          GestureDetector(
                            onTap: () {
                              if (topicBox.get(topicKey)?.cardSet != null) {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 200),
                                    reverseTransitionDuration:
                                        const Duration(milliseconds: 200),
                                    opaque: true,
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return FlashcardPresent(
                                        topicKey: topicKey,
                                      );
                                    },
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      return SlideTransition(
                                        position: Tween<Offset>(
                                          begin: const Offset(0, 1),
                                          end: Offset.zero,
                                        ).animate(animation),
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                            child: Image.asset(
                              'assets/icons/document.png',
                              height: 40,
                              color: (topicBox.get(topicKey)?.cardSet != null)
                                  ? Theme.of(context).colorScheme.secondary
                                  : Colors.white38,
                            ),
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
