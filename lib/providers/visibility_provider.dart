import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pomodoro_app/main.dart';
import 'package:pomodoro_app/models/selectedModel.dart';

class BottomBarVisibility extends ChangeNotifier {
  bool _isVisible = true;
  bool _isDarkMode = defaultKey.get(0)?.isDarkMode ?? true;
  bool get isVisible => _isVisible;
  bool get isDarkMode => _isDarkMode;

  void toggleVisibility(bool value) {
    _isVisible = value;

    if (value == false) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    }

    if (value == true) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
    }

    notifyListeners();
  }

  void toggleMode() {
    var topicKey = defaultKey.get(0)?.selectedTopic;
    var profileKey = defaultKey.get(0)?.selectedProfile;

    if (defaultKey.get(0)?.isDarkMode == null) {
      defaultKey.put(
        0,
        SelectedModel(
            selectedProfile: profileKey,
            selectedTopic: topicKey,
            isDarkMode: false),
      );
    } else {
      defaultKey.put(
        0,
        SelectedModel(
          selectedProfile: profileKey,
          selectedTopic: topicKey,
          isDarkMode: !defaultKey.get(0)!.isDarkMode!,
        ),
      );
    }

    _isDarkMode = defaultKey.get(0)!.isDarkMode!;

    notifyListeners();
  }
}
