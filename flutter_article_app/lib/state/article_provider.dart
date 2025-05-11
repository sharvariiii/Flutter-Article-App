// Provides state management for favorites
import 'package:flutter/foundation.dart'; // For ChangeNotifier
import 'package:shared_preferences/shared_preferences.dart'; // For local persistence
import '../utils/constants.dart';

class ArticleProvider extends ChangeNotifier {
  // Internal set to track favorite article IDs
  final Set<int> _favorites = {};

  // Public getter to access favorites from outside
  Set<int> get favorites => _favorites;

  // Load favorites from shared preferences when app starts or provider is initialized
  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favList = prefs.getStringList(kFavoritesKey) ?? [];

    // Convert stored string list back to integers and add to _favorites set
    _favorites.addAll(favList.map(int.parse));

    // Notify listeners so UI updates if needed
    notifyListeners();
  }

  // Toggle favorite status for an article by ID
  Future<void> toggleFavorite(int id) async {
    if (_favorites.contains(id)) {
      // If already a favorite, remove it
      _favorites.remove(id);
    } else {
      // If not a favorite, add it
      _favorites.add(id);
    }

    // Save the updated favorites list to shared preferences
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      kFavoritesKey,
      _favorites.map((e) => e.toString()).toList(),
    );

    // Notify UI that favorites have changed
    notifyListeners();
  }
}
