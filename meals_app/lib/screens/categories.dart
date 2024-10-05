import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/providers/meal_provider.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:meals_app/models/category.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({
    super.key
  });

  void _selectCategory(BuildContext context, Category category, WidgetRef ref) {
    // List that only contains the meal with the matching category id.
    final filteredMeals = MealProvider.getFilteredMealsInCategory(ref, category.id);

    // Same as Navigator.of(context).push(route).
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView(
      padding: const EdgeInsets.all(24),
      // Need gridDelegate that is required, controls the layout of the GridView.
      // The long thing below just allows you to set how many columns you want.
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio:
              3 / 2, // 3 / 2 for dynamically setting ratio to 3/2 aspect
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      children: [
        // alternative for using the availableCategories.map((category)) => CategoryGridItem(category: category)
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _selectCategory(context, category, ref);
            },
          )
      ],
    );
  }
}
