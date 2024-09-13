import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:school_match/domain/models/enums/themes.dart';
import 'package:school_match/ui/style/app_themes.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = AppThemes.classicTheme; // Default initialization

  ThemeProvider() {
    _loadTheme(); // Load the theme at initialization
  }

  ThemeData get themeData => _themeData; // Public getter to access the current theme

  final GetStorage box = GetStorage(); // Instance of GetStorage to persist theme choice

  void setTheme(Themes theme) {
    switch (theme) {
      case Themes.classicTheme:
        _themeData = AppThemes.classicTheme;
        box.write('theme', 'classicTheme');
        break;
      case Themes.darkTheme:
        _themeData = AppThemes.darkTheme;
        box.write('theme', 'darkTheme');
        break;
      case Themes.lightTheme:
        _themeData = AppThemes.lightTheme;
        box.write('theme', 'lightTheme');
        break;
    }
    notifyListeners(); // Notify listeners about theme change
  }

   Themes getCurrentTheme() {
    // Converts the current ThemeData to corresponding Themes enum
    if (_themeData == AppThemes.classicTheme) {
      return Themes.classicTheme;
    } else if (_themeData == AppThemes.darkTheme) {
      return Themes.darkTheme;
    } else if (_themeData == AppThemes.lightTheme) {
      return Themes.lightTheme;
    } else {
      return Themes.classicTheme; // Default to classic theme
    }
  }

  void _loadTheme() {
    String? themeName = box.read('theme') ?? 'classicTheme';
    switch (themeName) {
      case 'classicTheme':
        _themeData = AppThemes.classicTheme;
        break;
      case 'darkTheme':
        _themeData = AppThemes.darkTheme;
        break;
      case 'lightTheme':
        _themeData = AppThemes.lightTheme;
        break;
    }
  }
}
