import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/meal_provider.dart';

class FavoritesProvider {
  static final Set<String> _favoriteIds = {};

  static final List<void Function(bool)> _subscribers = [];

  static List<Meal> getFavorites() {
    return MealProvider.meals
      .where((meal) => isFavorie(meal.id))
      .toList();
  }

  static bool isFavorie(String mealId) {
    return _favoriteIds.contains(mealId);
  }

  static void addFavorite(String mealId) {
    _favoriteIds.add(mealId);
    _notifySubscribers(true);
  }

  static void removeFavorite(String mealId) {
    _favoriteIds.remove(mealId);
    _notifySubscribers(false);
  }

  /// Toggles whether or not a meal is considered a favorite.
  ///
  /// Returns whether the operation made the meal into a favorite.
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

  static void subscribe(void Function(bool) callback) {
    _subscribers.add(callback);
  }
}