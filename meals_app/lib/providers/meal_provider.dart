import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/filter_provider.dart';

class MealProvider {
  static List<Meal> meals = dummyMeals;

  /// Gets a set of meals which exist in the given [categoryId].
  ///
  /// Either gets the set from all available meals, or a provided [mealCollection].
  static List<Meal> getMealsInCategory(String categoryId, [List<Meal>? mealCollection]) {
    List<Meal> toBeChecked = mealCollection ?? meals;

    return toBeChecked
      .where((meal) => meal.categories.contains(categoryId))
      .toList();
  }

  /// Gets a set of meals which pass the currently applied filters.
  ///
  /// Either gets the set from all available meals, or a provided [mealCollection].
  static List<Meal> getFilteredMeals([List<Meal>? mealCollection]) {
    List<Meal> toBeChecked = mealCollection ?? meals;

    return toBeChecked
      .where((meal) => FilterProvider.passesFilter(meal.mealFilterProperties))
      .toList();
  }

  /// Wrapper around [getMealsInCategory] and [getFilteredMeals].
  ///
  /// Either gets the set from all available meals, or a provided [mealCollection].
  static List<Meal> getFilteredMealsInCategory(String categoryId, [List<Meal>? mealCollection]) {
    List<Meal> toBeChecked = mealCollection ?? meals;

    return getFilteredMeals(getMealsInCategory(categoryId, toBeChecked));
  }
}