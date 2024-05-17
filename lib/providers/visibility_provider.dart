import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BottomBarVisibility extends ChangeNotifier {
  bool _isVisible = true;
  bool get isVisible => _isVisible;

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
}
