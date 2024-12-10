import 'package:pomodoro_app/models/profileModel.dart';

class InitialPresets {
  List<profileModel> presets = [
    profileModel(
      'Standard',
      25,
      5,
      15,
      'audio/Rain.mp3',
      'audio/ringtone_1.mp3',
    ),
    profileModel(
      'Balanced',
      30,
      5,
      30,
      'audio/Rain.mp3',
      'audio/ringtone_1.mp3',
    ),
    profileModel(
      'Intense',
      55,
      5,
      60,
      'audio/Rain.mp3',
      'audio/ringtone_1.mp3',
    ),
  ];
}
