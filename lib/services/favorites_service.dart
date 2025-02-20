import 'package:shared_preferences/shared_preferences.dart';
import '../models/boss.dart';

class FavoritesService {
  static const String _key = 'favorites';
  
  static Future<void> toggleFavorite(Boss boss) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_key) ?? [];
    
    if (boss.isFavorite) {
      favorites.remove(boss.name);
    } else {
      favorites.add(boss.name);
    }
    
    await prefs.setStringList(_key, favorites);
    boss.isFavorite = !boss.isFavorite;
  }

  static Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }
} 