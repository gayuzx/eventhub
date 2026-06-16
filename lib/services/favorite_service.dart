import 'package:shared_preferences/shared_preferences.dart';
import '../models/event_model.dart';
import 'dart:convert';

class FavoriteService {
  static final List<Event> _favorites = [];

  static List<Event> getFavorites() => _favorites;

  // 🔄 Load favorites from SharedPreferences
  static Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getStringList("favorites") ?? [];
    _favorites.clear();
    _favorites.addAll(savedData.map((e) => Event.fromJson(jsonDecode(e))));
  }

  // 💾 Save favorites to SharedPreferences
  static Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final data = _favorites.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList("favorites", data);
  }

  static Future<void> addFavorite(Event event) async {
    if (!_favorites.contains(event)) {
      _favorites.add(event);
      await saveFavorites();
    }
  }

  static Future<void> removeFavorite(Event event) async {
    _favorites.remove(event);
    await saveFavorites();
  }

  static bool isFavorite(Event event) => _favorites.contains(event);
}
