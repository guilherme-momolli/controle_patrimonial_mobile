import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;
  

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
  
  ThemeData get themeData {
    return _isDarkMode ? ThemeData.dark() : ThemeData.light();
  }
}
