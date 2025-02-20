import 'package:flutter/material.dart';
import '../services/preferences_service.dart';
import '../models/user_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  UserPreferences _preferences;

  ThemeProvider(this._preferences);

  bool get isDarkMode => _preferences.isDarkMode;

  Future<void> toggleTheme() async {
    _preferences = _preferences.copyWith(isDarkMode: !_preferences.isDarkMode);
    await PreferencesService.savePreferences(_preferences);
    notifyListeners();
  }
} 