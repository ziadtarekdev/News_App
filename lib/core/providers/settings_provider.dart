import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  String currentLanguage = 'en';

  void changeLanguage(String lang) {
    if (currentLanguage == lang) return;
    currentLanguage = lang;
    notifyListeners();
  }
}
