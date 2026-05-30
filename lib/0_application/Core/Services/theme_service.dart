import 'package:flutter/cupertino.dart';

class ThemeService extends ChangeNotifier {
  bool isDarkModeOn = false;

  void onChanged() {
    isDarkModeOn = !isDarkModeOn;
    notifyListeners();
  }
}
