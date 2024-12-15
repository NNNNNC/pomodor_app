import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pomodoro_app/main.dart';
import 'package:pomodoro_app/providers/visibility_provider.dart';
import 'package:pomodoro_app/theme/customColors.dart';
import 'package:pomodoro_app/user_manual/pomodoroManual_display.dart';
import 'package:pomodoro_app/utils/calculator/calculator_page.dart';
import 'package:pomodoro_app/utils/data_init/audiomaps.dart';
import 'package:pomodoro_app/utils/scribble/scribble_page.dart';
import 'package:pomodoro_app/utils/widgets/dialogs/audio_select.dart';
import 'package:pomodoro_app/utils/others/flashcard_present.dart';
import 'package:pomodoro_app/utils/widgets/dialogs/task_add_dialog.dart';
import 'package:pomodoro_app/utils/widgets/tiles/mini_task_tile.dart';
import 'package:pomodoro_app/utils/others/sliding_app_bar.dart';
import 'package:pomodoro_app/utils/widgets/dialogs/taskDialog.dart';
import 'package:pomodoro_app/utils/widgets/dialogs/topic_dialog.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:rotating_icon_button/rotating_icon_button.dart';
import 'package:headset_connection_event/headset_event.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:scribble/scribble.dart';

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
  late TextEditingController _whiteNoiseController;
  late TextEditingController _taskController;
  late ScribbleNotifier notifier;
  int? topicKey;
  int? profileKey;
  int? focusDur, breakDur, longBreakDur, pomodoroCount;
  String whiteNoise = '', ringTone = '';
  List<dynamic>? topicTasks;
  int? topicCardSet;

  final _headsetPlugin = HeadsetEvent();
  HeadsetState? _headsetState;

  @override
  void initState() {
    topicKey = defaultKey.get(0)?.selectedTopic;
    profileKey = defaultKey.get(0)?.selectedProfile;
    topicTasks = topicBox.get(topicKey)?.tasks;
    topicCardSet = topicBox.get(topicKey)?.cardSet ?? null;
    whiteNoise = profileBox.get(profileKey)?.whiteNoise ?? 'audio/Dryer.mp3';
    ringTone = profileBox.get(profileKey)?.ringtone ?? 'audio/ringtone_1.mp3';
    focusDur = profileBox.get(profileKey)?.focusDuration ?? 25;
    breakDur = profileBox.get(profileKey)?.shortBreak ?? 5;
    longBreakDur = profileBox.get(profileKey)?.longBreak ?? 15;
    pomodoroCount = profileBox.get(profileKey)?.pomodoroCounter ?? 3;

    _whiteNoiseController = TextEditingController();
    _taskController = TextEditingController();

    notifier = ScribbleNotifier(widths: [5, 10, 15, 20, 25]);

    super.initState();

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _headsetPlugin.getCurrentState.then((_val) {
      setState(() {
        _headsetState = _val;
      });
    });

    _headsetPlugin.setListener((_val) {
      setState(() {
        _headsetState = _val;
      });
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    audioPlayer.dispose();
    allowNotifications();
    super.dispose();
  }

  bool hasShownDialog = false;
  int _remainingSeconds = 0;
  bool _isLongPressTrue = false;
  bool isPlaying = false;
  bool isMuted = false;
  bool isFocusing = false;
  bool isBreak = false;
  bool isLongBreak = false;
  bool timerStarted = false;
  bool pause = false;
  bool pauseTransition = false;
  Timer? timer;
  Timer? _longPressTimer;
  Timer? _speedIncreaseTimer;
  int seconds = 0, minutes = 0;
  int breakCounter = 0;
  int setMinute = 0;
  String digitSec = '00';
  String digitMin = '00';
  String? currentNoise;
  var colors = CustomColors();
  final audioPlayer = AudioPlayer();
  final Duration customLongPressDuration = Duration(seconds: 2);
  double _speedMultiplier = 1.0;

  void _logFocusSession() {
    final int focusDurationInSeconds =
        (focusDur! * 60) - (minutes * 60 + seconds);

    final DateTime now = DateTime.now();
    final Map<String, dynamic> sessionData = {
      'date': now.toIso8601String(),
      'duration': focusDurationInSeconds,
    };

    final sessionBox = Hive.box('focusSessions');
    sessionBox.add(sessionData);
  }

  void _taskStatusChange(bool? value, int index) {
    setState(() {
      topicTasks![index][1] = !topicTasks![index][1];
    });
  }

  void _createNewTask(String task) {
    topicTasks!.add([task, false]);
  }

  void suppressNotifications() async {
    final bool? isNotificationPolicyAccessGranted =
        await FlutterDnd.isNotificationPolicyAccessGranted;

    // turn on do not disturb (still allows alarms)
    if (isNotificationPolicyAccessGranted != null &&
        isNotificationPolicyAccessGranted) {
      await FlutterDnd.setInterruptionFilter(
          FlutterDnd.INTERRUPTION_FILTER_ALARMS);
    } else {
      FlutterDnd.gotoPolicySettings();
    }
  }

  void allowNotifications() async {
    final bool? isNotificationPolicyAccessGranted =
        await FlutterDnd.isNotificationPolicyAccessGranted;

    // turn off do not disturb
    if (isNotificationPolicyAccessGranted != null &&
        isNotificationPolicyAccessGranted) {
      await FlutterDnd.setInterruptionFilter(
          FlutterDnd.INTERRUPTION_FILTER_ALL);
    } else {
      FlutterDnd.gotoPolicySettings();
    }
  }

  void playSound(String filepath) async {
    final settingBox = Hive.box('settings');
    bool isWhiteNoiseDisabled =
        settingBox.get('disableNoise', defaultValue: false);

    // will only play sound if white noise is enabled
    if (!isWhiteNoiseDisabled) {
      await audioPlayer.play(
        AssetSource(filepath),
        mode: PlayerMode.lowLatency,
      );
    }
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

    if (isFocusing) {
      _logFocusSession();
    }

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
    if (isFocusing) {
      _logFocusSession();
    }

    final visibility = context.read<BottomBarVisibility>();

    allowNotifications();

    timer!.cancel();
    setState(() {
      pause = false;
      pauseTransition = false;
      _isLongPressTrue = false;
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

    pauseTransition = false;
    isPlaying = true;
    playSound(currentNoise ?? whiteNoise);
    loop();

    _startPeriodicTimer();
  }

  void _startPeriodicTimer() {
    timer?.cancel();

    Duration duration =
        Duration(milliseconds: (1000 ~/ _speedMultiplier).toInt());

    timer = Timer.periodic(duration, (timer) {
      setState(() {
        if (seconds == 0) {
          minutes--;
          seconds = 60;
        }
        seconds--;

        digitSec = (seconds >= 10) ? "$seconds" : "0$seconds";
        digitMin = (minutes >= 10) ? "$minutes" : "0$minutes";

        if ((minutes == 0) && (seconds == 0)) {
          timerStop();
        }
      });
    });
  }

  void fastForwardTimer(double speed) {
    if (speed <= 0) return;
    _speedMultiplier = speed;

    if (timer != null && timer!.isActive) {
      _startPeriodicTimer();
    }
  }

  void revertTimerSpeed() {
    _speedMultiplier = 1.0;

    if (timer != null && timer!.isActive) {
      _startPeriodicTimer();
    }
  }

  void pauseTimer() {
    pause = true;
    if (timer != null && timer!.isActive) {
      _remainingSeconds = (minutes * 60) + seconds;
      timer!.cancel();
      setState(() {
        isPlaying = false;
      });
      stopAudio();
    }
  }

  void resumeTimer() {
    pause = false;
    if (_remainingSeconds > 0 && !isPlaying) {
      setState(() {
        timerStarted = true;
        isPlaying = true;
      });
      playSound(currentNoise ?? whiteNoise);
      loop();

      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _remainingSeconds--;
          minutes = _remainingSeconds ~/ 60;
          seconds = _remainingSeconds % 60;

          digitSec = (seconds >= 10) ? "$seconds" : "0$seconds";
          digitMin = (minutes >= 10) ? "$minutes" : "0$minutes";

          if (_remainingSeconds <= 0) {
            timerStop();
          }
        });
      });
    }
  }

  void _startLongPressTimer() {
    _longPressTimer = Timer(customLongPressDuration, () {
      setState(() {
        terminateTimer();
      });
    });
  }

  void _cancelLongPressTimer() {
    _longPressTimer?.cancel();
    _longPressTimer = null;
    setState(() {
      _isLongPressTrue = false;
    });
  }

  // focus methods

  void focus() async {
    final visibility = context.read<BottomBarVisibility>();

    suppressNotifications();

    setState(() {
      isFocusing = !isFocusing;
      isBreak = false;
      isLongBreak = false;

      visibility.toggleVisibility(!isFocusing);

      setMinute = focusDur!;
      digitMin = (setMinute >= 10) ? "$setMinute" : "0$setMinute";
    });
  }

  void shortBreak() async {
    final visibility = context.read<BottomBarVisibility>();

    allowNotifications();

    setState(() {
      isFocusing = false;
      isBreak = !isBreak;
      isLongBreak = false;

      visibility.toggleVisibility(!isBreak);

      setMinute = breakDur!;
      digitMin = (setMinute >= 10) ? "$setMinute" : "0$setMinute";
    });
  }

  void longBreak() async {
    final visibility = context.read<BottomBarVisibility>();

    allowNotifications();

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
    final settingBox = Hive.box('settings');
    bool isLongBreakDisabled =
        settingBox.get('disableLongBreak', defaultValue: false);

    setState(() {
      pauseTransition = true;
      if (isFocusing) {
        isFocusing = false;

        if (breakCounter <= pomodoroCount!) {
          shortBreak();
        } else {
          if (!isLongBreakDisabled) {
            longBreak();
            breakCounter = 0;
          }
          shortBreak();
        }
      } else if (isBreak) {
        isBreak = false;
        focus();
        if (!isLongBreakDisabled) {
          breakCounter++;
        }
      } else if (isLongBreak) {
        isLongBreak = false;
      }
    });
  }

  void initializeSettings() {
    setState(() {
      topicKey = defaultKey.get(0)?.selectedTopic;
      profileKey = defaultKey.get(0)?.selectedProfile;
      topicTasks = topicBox.get(topicKey)?.tasks ?? [];
      topicCardSet = topicBox.get(topicKey)?.cardSet ?? null;
      whiteNoise = profileBox.get(profileKey)?.whiteNoise ?? 'audio/Dryer.mp3';
      ringTone = profileBox.get(profileKey)?.ringtone ?? 'audio/ringtone_1.mp3';
      focusDur = profileBox.get(profileKey)?.focusDuration ?? 25;
      breakDur = profileBox.get(profileKey)?.shortBreak ?? 5;
      longBreakDur = profileBox.get(profileKey)?.longBreak ?? 15;
      pomodoroCount = profileBox.get(profileKey)?.pomodoroCounter ?? 3;
      breakCounter = 0;
      focus();
    });
  }

  void toggleTimer() {
    setState(() {
      revertTimerSpeed();
      _speedIncreaseTimer?.cancel();
      timerStarted ? terminateTimer() : startTimer();
      pause = false;
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

  int? getCardSet(int? index) {
    return flashcardBox.get(index)?.key;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final int totalDuration =
        isFocusing ? focusDur! : (isBreak ? breakDur! : longBreakDur!);
    final double progress =
        (totalDuration * 60 - (seconds + minutes * 60)) / (totalDuration * 60);
    final settingBox = Hive.box('settings');
    return Consumer<BottomBarVisibility>(
      builder: (context, value, child) => Scaffold(
        resizeToAvoidBottomInset: false,
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
                  actions: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                        icon: Icon(
                          Icons.info_outline_rounded,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => pomodoroManualDisplay(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              : const PreferredSize(
                  preferredSize: Size.fromHeight(100.0),
                  child: SizedBox(height: 30.0),
                ),
        ),
        floatingActionButton: (value.isusingCustom || !value.isVisible)
            ? null
            : SizedBox(
                height: 45,
                width: 45,
                child: FloatingActionButton(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  shape: const CircleBorder(),
                  heroTag: 'modeSwitch',
                  onPressed: () {},
                  child: RotatingIconButton(
                    rotateType: RotateType.full,
                    duration: Durations.medium4,
                    background: Theme.of(context).colorScheme.surface,
                    shape: ButtonShape.circle,
                    onTap: () {
                      value.toggleMode();
                      setState(() {});
                    },
                    child: Icon(
                      value.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                      color: Theme.of(context).highlightColor,
                      size: 30,
                    ),
                  ),
                ),
              ),

        // Select topic and headphones
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
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
                          topicCardSet =
                              topicBox.get(topicKey)?.cardSet ?? null;
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

              if ((isFocusing || isBreak || isLongBreak) &&
                  (settingBox.get('disableLongBreak', defaultValue: false) ==
                      false))
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    (breakCounter < pomodoroCount!)
                        ? (pomodoroCount! - breakCounter).toString() +
                            ' Pomodoros until long break'
                        : 'Long break achieved!',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
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
                        color: isFocusing
                            ? Theme.of(context).primaryColorDark
                            : Theme.of(context).primaryColor,
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
                        color: isLongBreak
                            ? Theme.of(context).primaryColorDark
                            : Theme.of(context).primaryColor,
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
                        color: isBreak
                            ? Theme.of(context).primaryColorDark
                            : Theme.of(context).primaryColor,
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
                    : (topicTasks == null || isBreak || isLongBreak)
                        ? 75
                        : 30,
              ),

              // focus Button
              AvatarGlow(
                startDelay: const Duration(milliseconds: 1000),
                glowShape: BoxShape.circle,
                glowRadiusFactor:
                    settingBox.get('enablePulse', defaultValue: true) ? 0.1 : 0,
                glowColor: Theme.of(context).colorScheme.primary,
                child: Stack(
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
                            ? colors.breakCircularBackground
                            : isLongBreak
                                ? colors.longCircularBackground
                                : colors.focusCircularBackground,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isFocusing
                              ? colors.focusCircularValue
                              : isBreak
                                  ? colors.breakCircularValue
                                  : isLongBreak
                                      ? colors.longCircularValue
                                      : Colors.transparent,
                        ),
                        strokeWidth: 8,
                      ),
                    ),
                    Material(
                      elevation: 20,
                      color: isFocusing == true
                          ? Theme.of(context).colorScheme.primaryContainer
                          : isBreak == true
                              ? Theme.of(context).colorScheme.secondaryContainer
                              : isLongBreak == true
                                  ? Theme.of(context)
                                      .colorScheme
                                      .tertiaryContainer
                                  : Theme.of(context)
                                      .colorScheme
                                      .surfaceContainerHighest,
                      type: MaterialType.circle,
                      child: InkWell(
                        onLongPress: (isFocusing || isBreak || isLongBreak)
                            ? () {}
                            : null,
                        customBorder: const CircleBorder(),
                        splashColor: Colors.white54,
                        highlightColor: Colors.black38,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            setState(() {
                              if (!isFocusing && !isBreak && !isLongBreak) {
                                initializeSettings();
                                toggleTimer();
                              } else if (isFocusing && !pauseTransition) {
                                pause ? resumeTimer() : pauseTimer();
                              } else if ((isBreak || isLongBreak) &&
                                  pauseTransition == true) {
                                toggleTimer();
                              } else if (isFocusing && pauseTransition) {
                                toggleTimer();
                              }
                            });
                            if (hasShownDialog &&
                                this._headsetState == HeadsetState.DISCONNECT) {
                              AwesomeDialog(
                                context: context,
                                customHeader:
                                    Image.asset('assets/icons/listening.png'),
                                animType: AnimType.scale,
                                title: 'Enhance Your Audio Experience',
                                desc: 'Use headphones or earphones.',
                                autoHide: const Duration(seconds: 2),
                                onDismissCallback: (type) {
                                  debugPrint(
                                      'Dialog Dismissed from callback $type');
                                },
                              ).show();

                              hasShownDialog = true;
                            }
                          },
                          onTapDown: (details) {
                            if (isFocusing || isBreak || isLongBreak)
                              setState(() {
                                _isLongPressTrue = true;
                              });
                          },
                          onTapUp: (details) {
                            if (isFocusing || isBreak || isLongBreak)
                              setState(() {
                                _isLongPressTrue = false;
                              });
                          },
                          onTapCancel: () {
                            if (isFocusing || isBreak || isLongBreak)
                              setState(() {
                                _isLongPressTrue = false;
                              });
                          },
                          onLongPressStart: (details) {
                            if (isFocusing || isBreak || isLongBreak) {
                              _isLongPressTrue = true;
                              _startLongPressTimer();
                            }
                          },
                          onLongPressEnd: (details) {
                            _cancelLongPressTimer();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.height * 0.3,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle,
                              // boxShadow: [
                              //   BoxShadow(
                              //     blurRadius: 1.5,
                              //     spreadRadius: 7,
                              //     offset: Offset.zero,
                              //     color: Colors.black.withOpacity(0.25),
                              //   ),
                              // ],
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    _isLongPressTrue
                                        ? 'EXITING'
                                        : pause
                                            ? 'PAUSED'
                                            : isFocusing && pause == false
                                                ? 'FOCUSING'
                                                : isBreak
                                                    ? 'BREAK'
                                                    : isLongBreak
                                                        ? 'LONG BREAK'
                                                        : 'FOCUS',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    _isLongPressTrue
                                        ? 'Release to cancel'
                                        : (pause || pauseTransition)
                                            ? 'Press to resume timer'
                                            : isFocusing ||
                                                    isBreak ||
                                                    isLongBreak
                                                ? '$digitMin:$digitSec'
                                                : 'Press here to start Pomodoro',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                      color: Theme.of(context).colorScheme.surface,
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
                              SizedBox(
                                width: 180,
                                child: Row(
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
                                    Flexible(
                                      child: Text(
                                        overflow: TextOverflow.ellipsis,
                                        ' (${topicBox.get(topicKey)?.name})',
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      size: 22,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return TaskAdd(
                                            controller: _taskController,
                                            onPressed: () {
                                              setState(() {
                                                _createNewTask(
                                                  _taskController.text,
                                                );
                                                _taskController.clear();
                                                Navigator.of(context).pop();
                                              });
                                            },
                                          );
                                        },
                                      );
                                    },
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                ],
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

              if ((isBreak || isLongBreak) &&
                  (settingBox.get('enableSkip', defaultValue: false) == true))
                InkWell(
                  highlightColor: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(36),
                  onLongPress: () {},
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onLongPressDown: (details) {
                      _speedIncreaseTimer?.cancel();

                      setState(() {
                        _speedMultiplier = 1.0;
                        fastForwardTimer(
                          _speedMultiplier,
                        );
                      });

                      _speedIncreaseTimer = Timer.periodic(
                          const Duration(milliseconds: 100), (timer) {
                        setState(() {
                          _speedMultiplier += 1.0;
                          fastForwardTimer(_speedMultiplier);
                        });
                      });
                    },
                    onLongPressCancel: () {
                      setState(() {
                        _speedIncreaseTimer?.cancel();
                        revertTimerSpeed();
                      });
                    },
                    onLongPressUp: () {
                      _speedIncreaseTimer?.cancel();
                      _speedIncreaseTimer = null;

                      setState(() {
                        revertTimerSpeed();
                      });
                    },
                    onLongPressEnd: (details) {
                      setState(() {
                        _speedIncreaseTimer?.cancel();
                        revertTimerSpeed();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.fast_forward,
                        color: Theme.of(context).highlightColor,
                        size: 30,
                      ),
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
                                  ? Theme.of(context).highlightColor
                                  : Theme.of(context).disabledColor,
                            ),
                            onPressed: () {
                              allowNotifications();
                              setState(() {
                                value.toggleVisibility(!value.isVisible);
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.calculate_outlined,
                              size: 32,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            onPressed: () {
                              showGeneralDialog(
                                barrierLabel: 'Label',
                                barrierDismissible: false,
                                barrierColor: Colors.black.withOpacity(0.5),
                                transitionDuration:
                                    const Duration(milliseconds: 400),
                                context: context,
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return CalculatorPage();
                                },
                                transitionBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(0, 1),
                                      end: Offset.zero,
                                    ).animate(animation),
                                    child: child,
                                  );
                                },
                              );
                            },
                          ),
                          GestureDetector(
                            onTap: () {
                              if (topicCardSet != null) {
                                if (getCardSet(topicCardSet!) != null) {
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
                              }
                            },
                            child: Image.asset(
                              'assets/icons/document.png',
                              height: 32,
                              color: (getCardSet(topicCardSet) != null)
                                  ? Theme.of(context).colorScheme.secondary
                                  : Theme.of(context).disabledColor,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.draw,
                              size: 28,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ScribblePage(
                                    key: PageStorageKey('ScribblePage'),
                                    notifier: notifier,
                                  ),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.multitrack_audio,
                                size: 28,
                                color: Theme.of(context).colorScheme.secondary),
                            onPressed: () {
                              showDialog<String>(
                                barrierDismissible: true,
                                context: context,
                                builder: (BuildContext context) => audioSelect(
                                  audioMap: WhiteNoise().whiteNoiseMap,
                                  controller: _whiteNoiseController,
                                  onTap: (selectedValue) {
                                    Navigator.of(context).pop(selectedValue);
                                  },
                                ),
                              ).then((selectedValue) {
                                setState(() {
                                  if (selectedValue != null) {
                                    currentNoise = selectedValue;
                                    stopAudio();
                                    playSound(currentNoise!);
                                  }
                                });
                              });
                            },
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
