import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user_preferences.dart';

class PreferencesService {
  static const String _prefsKey = 'user_preferences';
  
  static Future<UserPreferences> getPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final String? prefsJson = prefs.getString(_prefsKey);
    if (prefsJson == null) return UserPreferences();
    
    return UserPreferences.fromJson(
      jsonDecode(prefsJson),
    );
  }

  static Future<void> savePreferences(UserPreferences preferences) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, jsonEncode(preferences.toJson()));
  }
} 