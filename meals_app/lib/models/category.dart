import 'package:flutter/material.dart';
import 'package:meals_app/providers/meal_provider.dart';

class Category {
  const Category({
    required this.id,
    required this.title,
    this.color = Colors.orange,
  });

  final String id;
  final String title;
  final Color color;

  /// Gets the amount of meals that are currently visible in the category,
  /// after applying filters.
  int getNumMealsVisibleInCategory() {
    return MealProvider.getFilteredMealsInCategory(id).length;
  }
}
