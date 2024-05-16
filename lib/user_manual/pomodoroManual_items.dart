import 'package:pomodoro_app/user_manual/manual_info.dart';

class pomodoroManualItems{
  List<manualInfo> items = [
    manualInfo(
      title: 'Welcome to POMODORO Manual, where you will learn how to use this application',
      image: 'assets/images/pomodoro.png'
      ),
    manualInfo(
      title: 'In using POMODORO just press the circle to start focusing',
      image: 'assets/images/manual_images/pomodoro_manual/pomodoro.png'
      ),
    manualInfo(
      title: 'During focus session you can select topics that you\'ve created then it will display the tasks list and you can also tap the headphone icon to mute the background music',
      image: 'assets/images/manual_images/pomodoro_manual/topic_audio.png'
      ),
    manualInfo(
      title: 'During focus session the back navigator of the phone is disabled, in this session you must do your tasks that you\'ve created',
      image: 'assets/images/manual_images/pomodoro_manual/focus.png'
      ),
    manualInfo(
      title: 'During focus session you can open the flashcard section by pressing the flashcard icon and the lock icon is for locking the pomodoro session so you can still edit your study environnment',
      image: 'assets/images/manual_images/pomodoro_manual/buttons.png'
      ),
    manualInfo(
      title: 'In the flashcard section the icon on the top corner is use for shuffling the flashcard, the flip button is use for checking the correct answer, and the X button is to return to the session page',
      image: 'assets/images/manual_images/pomodoro_manual/flashcard.png'
      ),
    manualInfo(
      title: 'After the focus session ends, you will be notify to take a short break before starting a new focus session',
      image: 'assets/images/manual_images/pomodoro_manual/shortbreak.png'
      ),
    manualInfo(
      title: 'After focusing 4x and having a short break 3x, you will be notified to take a long break in studying',
      image: 'assets/images/manual_images/pomodoro_manual/longbreak.png'
      ),
  ];
}