import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:school_match/domain/models/enums/themes.dart';
import 'package:school_match/ui/style/app_themes.dart';

class ThemeProvider extends ChangeNotifier {
  final BuildContext context;
  late AppThemes appThemes;
  late ThemeData _themeData;

  ThemeProvider(this.context) {
    appThemes = AppThemes(context);
    _themeData = appThemes.classicTheme; // Default initialization
    _loadTheme(); // Load the theme at initialization
  }

  ThemeData get themeData =>
      _themeData; // Public getter to access the current theme

  final GetStorage box =
      GetStorage(); // Instance of GetStorage to persist theme choice

  void setTheme(Themes theme) {
    switch (theme) {
      case Themes.classicTheme:
        _themeData = appThemes.classicTheme;
        box.write('theme', 'classicTheme');
        break;
      case Themes.darkTheme:
        _themeData = appThemes.darkTheme;
        box.write('theme', 'darkTheme');
        break;
      case Themes.lightTheme:
        _themeData = appThemes.lightTheme;
        box.write('theme', 'lightTheme');
        break;
    }
    notifyListeners(); // Notify listeners about theme change
  }

  Themes getCurrentTheme() {
    // Converts the current ThemeData to corresponding Themes enum
    if (_themeData == appThemes.classicTheme) {
      return Themes.classicTheme;
    } else if (_themeData == appThemes.darkTheme) {
      return Themes.darkTheme;
    } else if (_themeData == appThemes.lightTheme) {
      return Themes.lightTheme;
    } else {
      return Themes.classicTheme; // Default to classic theme
    }
  }

  void _loadTheme() {
    String? themeName = box.read('theme') ?? 'classicTheme';
    switch (themeName) {
      case 'classicTheme':
        _themeData = appThemes.classicTheme;
        break;
      case 'darkTheme':
        _themeData = appThemes.darkTheme;
        break;
      case 'lightTheme':
        _themeData = appThemes.lightTheme;
        break;
    }
  }
}
