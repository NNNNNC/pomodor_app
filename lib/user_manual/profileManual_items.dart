import 'package:pomodoro_app/user_manual/manual_info.dart';

class profileManualItems {
  List<manualInfo> items = [
    manualInfo(
        title:
            'Welcome to our profile manual, where you can create your own environment while studying',
        image: 'assets/images/profile.png'),
    manualInfo(
        title:
            'You can add multiple profile for different learning environment by tapping the floating action button and then by tapping the three dots to select a profile',
        image: 'assets/images/manual_images/profile_manual/profile.png'),
    manualInfo(
        title:
            'In editing the timer you must select your preffered time of focus and break session',
        image: 'assets/images/manual_images/profile_manual/timer_audio.png'),
    manualInfo(
        title:
            'You can also edit your preffered audio, white noise for background music and ringtone while using pomodoro',
        image: 'assets/images/manual_images/profile_manual/timer_audio.png'),
    manualInfo(
        title:
            'You can also edit your name by tapping the profile title, then press the check icon to save your profile study environment',
        image: 'assets/images/manual_images/profile_manual/name_save.png'),
  ];
}
