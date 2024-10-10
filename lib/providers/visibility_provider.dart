import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pomodoro_app/main.dart';
import 'package:pomodoro_app/models/selectedModel.dart';
import 'package:pomodoro_app/theme/theme.dart';

class BottomBarVisibility extends ChangeNotifier {
  bool _isVisible = true;
  bool _isDarkMode = defaultKey.get(0)?.isDarkMode ?? true;
  bool _usingCustom = Hive.box('themePrefs').get(0) ?? false;
  String _customTheme = Hive.box('themePrefs').get(1) ?? 'simple';
  bool get isVisible => _isVisible;
  bool get isDarkMode => _isDarkMode;
  bool get isusingCustom => _usingCustom;
  String get customTheme => _customTheme;

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

  void toggleCustomTheme() {
    final themeBox = Hive.box('themePrefs');

    var topicKey = defaultKey.get(0)?.selectedTopic;
    var profileKey = defaultKey.get(0)?.selectedProfile;

    defaultKey.put(
      0,
      SelectedModel(
        selectedProfile: profileKey,
        selectedTopic: topicKey,
        isDarkMode: true,
      ),
    );

    _usingCustom = themeBox.get(0);
    _customTheme = themeBox.get(1);

    notifyListeners();
  }

  ThemeData getCustomTheme() {
    String themeTitle = Hive.box('themePrefs').get(1);

    if (themeTitle == 'forest') {
      return forest_theme;
    } else if (themeTitle == 'underwater') {
      return underwater_theme;
    } else if (themeTitle == 'modern') {
      return purple_modern_theme;
    } else if (themeTitle == 'choco') {
      return wooden_theme;
    } else if (themeTitle == 'rosy') {
      return rosy_theme;
    } else {
      return zen_theme;
    }
  }
}
