import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/meal_provider.dart';

/// Handles storage of favorites.
/// Follows a subscribable pattern, so that objects can listen for
/// whenever a favorite is added or removed.
class FavoritesProvider {
  static final Set<String> _favoriteIds = {};

  static final List<void Function(bool)> _subscribers = [];

  /// Returns the current favorite meals
  static List<Meal> getFavorites() {
    return MealProvider.meals
      .where((meal) => isFavorie(meal.id))
      .toList();
  }

  /// Checks if a meal is a favorite by its id
  static bool isFavorie(String mealId) {
    return _favoriteIds.contains(mealId);
  }

  /// Adds a new meal to favorites.
  ///
  /// Notifies subscribers.
  static void addFavorite(String mealId) {
    _favoriteIds.add(mealId);
    _notifySubscribers(true);
  }

  /// Removes a meal from favorites.
  ///
  /// Notifies subscribers.
  static void removeFavorite(String mealId) {
    _favoriteIds.remove(mealId);
    _notifySubscribers(false);
  }

  /// Toggles whether or not a meal is considered a favorite.
  ///
  /// Returns whether the operation made the meal into a favorite. Also
  /// notifies subscribers.
  static bool toggleFavorite(String mealId) {
    bool wasFavorite = isFavorie(mealId);

    if (wasFavorite) {
      removeFavorite(mealId);
    } else {
      addFavorite(mealId);
    }

    return !wasFavorite;
  }

  static void _notifySubscribers(bool wasAdded) {
    for (void Function(bool) callback in _subscribers) {
      callback(wasAdded);
    }
  }

  /// Subscribes a callback for whenever something was added or removed from
  /// favorites. Boolean argument of [callback] is true if something was added,
  /// and false if removed.
  static void subscribe(void Function(bool) callback) {
    _subscribers.add(callback);
  }
}