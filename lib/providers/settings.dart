import 'package:flutter/cupertino.dart';

class Settings with ChangeNotifier {
  bool darkMode = false;
  bool showReminders = false;

  void toggleAppMode() {
    darkMode = !darkMode;
    notifyListeners();
  }

  void toggleReminders() {
    showReminders = !showReminders;
    notifyListeners();
  }

  get appMode {
    if (darkMode) {
      return Brightness.dark;
    } else {
      return Brightness.light;
    }
  }
}
