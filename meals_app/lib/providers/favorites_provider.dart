import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Handles storage of favorites.
/// Follows RiverPod's recommended solution for managing states.
class FavoritesProvider extends StateNotifier<Set<String>> {
  FavoritesProvider() : super({});

  /// Toggles the favorite food on / off depending on current state.
  void toggleFavorite(String mealId) {
    if (state.contains(mealId)) {
      state = {...state}..remove(mealId);
    } else {
      state = {...state, mealId};
    }
  }

  /// Check to see if a meal is favorited or not.
  bool isFavorite(String mealId) => state.contains(mealId);
}

/// provides access to the favorites provider through riverpod.
final favoritesProvider = StateNotifierProvider<FavoritesProvider, Set<String>>((ref) {
  return FavoritesProvider();
});