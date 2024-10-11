import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_details.dart';
import 'package:meals_app/widgets/meal_item.dart';

/// Screen for displaying a list of selectable meals.
///
/// Allows user to choose a meal from a specific category.
class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals
  });

  final String? title;
  final List<Meal> meals;

  /// Handles the navigation to the [MealDetailsScreen],
  /// when a user taps on a [Meal].
  void selectMeal(BuildContext context, meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meal: meal
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Listview: scrolling widget, optimized for a list of column items.
    Widget content = ListView.builder(
        // Important to tell Flutter how many you want to display.
        itemCount: meals.length,
        itemBuilder: (ctx, index) => MealItem(
              meal: meals.elementAt(index),
              onSelectMeal: (meal) {
                selectMeal(context, meal);
              },
            ));

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'No Meals Added!',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Try Adding a Meal to Favorites',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ],
        ),
      );
    }

    if (title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
