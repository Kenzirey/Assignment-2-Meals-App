import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/persistence/favorite_persistency.dart';

/// Handles storage of favorites.
/// Follows RiverPod's recommended solution for managing states.
class FavoritesProvider extends StateNotifier<Set<String>> {
  FavoritesProvider() : super({}) {
    loadFromPersistence();
  }

  void loadFromPersistence() async {
    state = await favoritePersistency.load();
  }

  /// Toggles the favorite food on / off depending on current state.
  void toggleFavorite(String mealId) {
    if (state.contains(mealId)) {
      state = {...state}..remove(mealId);
    } else {
      state = {...state, mealId};
    }

    favoritePersistency.save(state);
  }

  /// Check to see if a meal is favorited or not.
  bool isFavorite(String mealId) => state.contains(mealId);
}

/// provides access to the favorites provider through riverpod.
final favoritesProvider = StateNotifierProvider<FavoritesProvider, Set<String>>((ref) {
  return FavoritesProvider();
});