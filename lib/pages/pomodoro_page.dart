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
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive =>
      isFocusing ||
      isBreak ||
      isLongBreak ||
      isMuted ||
      isPlaying ||
      timerStarted;

  late AnimationController _slideController;
  int? topicKey;
  int? profileKey;
  int? focusDur, breakDur, longBreakDur;
  String whiteNoise = '', ringTone = '';
  List<dynamic>? topicTasks;

  @override
  void initState() {
    topicKey = defaultKey.get(0)?.selectedTopic;
    profileKey = defaultKey.get(0)?.selectedProfile;
    topicTasks = topicBox.get(topicKey)?.tasks;
    whiteNoise = profileBox.get(profileKey)?.whiteNoise ?? 'audio/Dryer.mp3';
    ringTone = profileBox.get(profileKey)?.ringtone ?? 'audio/ringtone_1.mp3';
    focusDur = profileBox.get(profileKey)?.focusDuration ?? 25;
    breakDur = profileBox.get(profileKey)?.shortBreak ?? 5;
    longBreakDur = profileBox.get(profileKey)?.longBreak ?? 15;

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
  bool pause = false;
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

      isPlaying = false;
      stopAudio();

      playSound(ringTone);
      loop();

      // transition to other states
      transition();
    });
  }

  void terminateTimer() {
    final visibility = context.read<BottomBarVisibility>();

    timer!.cancel();
    setState(() {
      isFocusing = false;
      isBreak = false;
      isLongBreak = false;
      seconds = 0;
      minutes = 0;
      digitMin = '00';
      digitSec = '00';

      timerStarted = false;

      isPlaying = false;
      stopAudio();

      visibility.toggleVisibility(true);
    });
  }

  void startTimer() {
    stopAudio();

    minutes = setMinute;
    timerStarted = true;

    isPlaying = true;
    playSound(whiteNoise);
    loop();

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

      setMinute = focusDur!;
      digitMin = (setMinute >= 10) ? "$setMinute" : "0$setMinute";
    });
  }

  void shortBreak() {
    final visibility = context.read<BottomBarVisibility>();

    setState(() {
      isFocusing = false;
      isBreak = !isBreak;
      isLongBreak = false;

      visibility.toggleVisibility(!isBreak);

      setMinute = breakDur!;
      digitMin = (setMinute >= 10) ? "$setMinute" : "0$setMinute";
    });
  }

  void longBreak() {
    final visibility = context.read<BottomBarVisibility>();

    setState(() {
      isFocusing = false;
      isBreak = false;
      isLongBreak = !isLongBreak;

      visibility.toggleVisibility(!isLongBreak);

      setMinute = longBreakDur!;
      digitMin = (setMinute >= 10) ? "$setMinute" : "0$setMinute";
    });
  }

  void transition() {
    setState(() {
      pause = true;
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
    super.build(context);
    final int totalDuration =
        isFocusing ? focusDur! : (isBreak ? breakDur! : longBreakDur!);
    final double progress =
        (totalDuration * 60 - (seconds + minutes * 60)) / (totalDuration * 60);
    return Consumer<BottomBarVisibility>(
      builder: (context, value, child) => Scaffold(
        appBar: SlidingAppBar(
          controller: _slideController,
          visible: value.isVisible,
          child: value.isVisible
              ? AppBar(
                  title: Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child: const Text(
                      "Pomodoro",
                      style: TextStyle(
                        fontSize: 18.5,
                      ),
                    ),
                  ),
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
                padding: const EdgeInsets.all(20.0),
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
                          fontSize: 13.5,
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
                        size: 22,
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
                    AnimatedContainer(
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
                      height: 32 - 4,
                      width: 71 - 4,
                      child: const Center(
                        child: Text(
                          'Focus',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    // Long Break State
                    AnimatedContainer(
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
                      height: 32 - 4,
                      width: 90 - 4,
                      child: const Center(
                        child: Text(
                          'Long Break',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    // Short break state
                    AnimatedContainer(
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
                      height: 32 - 4,
                      width: 71 - 4,
                      child: const Center(
                        child: Text(
                          'Break',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: value.isVisible
                    ? 72
                    : (topicTasks == null)
                        ? 125
                        : 30,
              ),

              // Focus Button
              Stack(
                children: [
                  // progress indicator
                  Positioned.fill(
                    top: MediaQuery.of(context).size.width / 60,
                    bottom: MediaQuery.of(context).size.width / 60,
                    left: 0,
                    right: 0,
                    child: CircularProgressIndicator(
                      value: progress,
                      backgroundColor: isBreak
                          ? const Color(0xff1dc50e)
                          : isLongBreak
                              ? const Color(0xff0e15c5)
                              : Colors.transparent,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        pause
                            ? Colors.transparent
                            : isFocusing
                                ? const Color(0xff1dc50e)
                                : isBreak
                                    ? const Color(0xff252525)
                                    : isLongBreak
                                        ? const Color(0xff252525)
                                        : Colors.transparent,
                      ),
                      strokeWidth: 8,
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      if (isFocusing == false &&
                          isBreak == false &&
                          isLongBreak == false) {
                        setState(() {
                          // reinitialize keys
                          topicKey = defaultKey.get(0)?.selectedTopic;
                          profileKey = defaultKey.get(0)?.selectedProfile;
                          topicTasks = topicBox.get(topicKey)?.tasks;
                          whiteNoise = profileBox.get(profileKey)?.whiteNoise ??
                              'audio/Dryer.mp3';
                          ringTone = profileBox.get(profileKey)?.ringtone ??
                              'audio/ringtone_1.mp3';
                          focusDur =
                              profileBox.get(profileKey)?.focusDuration ?? 25;
                          breakDur =
                              profileBox.get(profileKey)?.shortBreak ?? 5;
                          longBreakDur =
                              profileBox.get(profileKey)?.longBreak ?? 15;

                          focus();
                        });
                      }
                      setState(() {
                        timerStarted ? terminateTimer() : startTimer();
                        pause = false;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 700),
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.3,
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
                              isFocusing && pause == false
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
                              pause
                                  ? 'Click here to start timer'
                                  : isFocusing || isBreak || isLongBreak
                                      ? '$digitMin:$digitSec'
                                      : 'Click here to start Pomodoro',
                              style: const TextStyle(
                                color: Color(0xffc0c0c0),
                                fontSize: 12,
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
                  (topicKey != null &&
                      topicTasks != null &&
                      isBreak == false &&
                      isLongBreak == false))
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
                                      fontSize: 13.0,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                  Text(
                                    ' (${topicBox.get(topicKey)?.name})',
                                    style: TextStyle(
                                      fontSize: 13.0,
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
                                  size: 22,
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

              if (value.isVisible == false && (isBreak || isLongBreak))
                const Expanded(
                  child: Center(
                    child: Text(
                      'Rest, relax, and recharge.\nYour productivity will thank you.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),

              if (value.isVisible == false &&
                  (topicKey == null || topicTasks == null) &&
                  (isBreak == false && isLongBreak == false))
                Expanded(
                  child: Center(
                    child: Text(
                      (topicKey == null)
                          ? 'Select a topic first to see your tasks.'
                          : 'Create tasks for more productivity!',
                      style: const TextStyle(fontSize: 14),
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
                              size: 28,
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
                              height: 32,
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
