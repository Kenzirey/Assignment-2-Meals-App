import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/filter_provider.dart';

class MealProvider {
  static Set<Meal> meals = dummyMeals.toSet();

  /// Gets a set of meals which exist in the given [categoryId].
  ///
  /// Either gets the set from all available meals, or a provided [mealCollection].
  static Set<Meal> getMealsInCategory(String categoryId, [Set<Meal>? mealCollection]) {
    Set<Meal> toBeChecked = mealCollection ?? meals;

    return toBeChecked
      .where((meal) => meal.categories.contains(categoryId))
      .toSet();
  }

  /// Gets a set of meals which pass the currently applied filters.
  ///
  /// Either gets the set from all available meals, or a provided [mealCollection].
  static Set<Meal> getFilteredMeals([Set<Meal>? mealCollection]) {
    Set<Meal> toBeChecked = mealCollection ?? meals;

    return toBeChecked
      .where((meal) => FilterProvider.passesFilter(meal.mealFilterProperties))
      .toSet();
  }

  /// Wrapper around [getMealsInCategory] and [getFilteredMeals].
  ///
  /// Either gets the set from all available meals, or a provided [mealCollection].
  static Set<Meal> getFilteredMealsInCategory(String categoryId, [Set<Meal>? mealCollection]) {
    Set<Meal> toBeChecked = mealCollection ?? meals;

    return getFilteredMeals(getMealsInCategory(categoryId, toBeChecked));
  }
}