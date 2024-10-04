import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Handles storage of favorites.
/// Follows a subscribable pattern, so that objects can listen for
/// whenever a favorite is added or removed.
class FavoritesNotifier extends StateNotifier<Set<String>> {
  FavoritesNotifier() : super({});

  /// Toggles the favorite food on / off depending on current state.
  void toggleFavorite(String mealId) {
    if (state.contains(mealId)) {
      state = {...state}..remove(mealId);
    } else {
      state = {...state, mealId};
    }
  }

  // Favorite prisoner food (●'◡'●)
  bool isFavorite(String mealId) => state.contains(mealId);
}

/// provides access to the favorites provider through riverpod.
final favoritesProvider = StateNotifierProvider<FavoritesNotifier, Set<String>>((ref) {
  return FavoritesNotifier();
});