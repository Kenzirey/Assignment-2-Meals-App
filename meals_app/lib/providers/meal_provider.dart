import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/filter_provider.dart';

// Create a Riverpod provider for meals
/// Provides access to the list of meals from the dummy_data.
final mealsProvider = Provider((ref) {
  return dummyMeals;
});

/// Manages meals based on applied filters.
/// Allows to show only the meals matching the filtered category.
class MealProvider {
  static List<Meal> meals = dummyMeals;

  /// Gets a set of meals which exist in the given [categoryId].
  ///
  /// Either gets the set from all available meals, or a provided [mealCollection].
  static List<Meal> getMealsInCategory(String categoryId,
      [List<Meal>? mealCollection]) {
    List<Meal> toBeChecked = mealCollection ?? meals;
    return toBeChecked
        .where((meal) => meal.categories.contains(categoryId))
        .toList();
  }

  /// Filters meals based on the currently applied filters.
  static List<Meal> getFilteredMeals(WidgetRef ref,
      [List<Meal>? mealCollection]) {
    List<Meal> toBeChecked = mealCollection ?? meals;

    /// Starts a watcher to listen on changes to filterProvider's state.
    /// will react to changes as they happen, like a subscribe button.
    ref.watch(filterProvider);

    //watch: triggers rebuild whenever the watched provider's state changes,
    // we want it to react to changes as they happen.

    /// Only return meals that pass the filter.
    return toBeChecked.where((meal) {
      return ref
          .read(filterProvider.notifier)
          .passesFilter(meal.mealFilterProperties);
    }).toList();
  }

  /// Wrapper around [getMealsInCategory] and [getFilteredMeals].
  static List<Meal> getFilteredMealsInCategory(WidgetRef ref, String categoryId,
      [List<Meal>? mealCollection]) {
    List<Meal> toBeChecked = mealCollection ?? meals;
    return getFilteredMeals(ref, getMealsInCategory(categoryId, toBeChecked));
  }
}
