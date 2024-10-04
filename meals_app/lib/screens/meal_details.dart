import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/favorites_provider.dart';

/// Widget for displaying all the information of a meal.
/// Allows user to add/remove a meal to favorites.
class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({super.key, required this.meal});

  // The childrens' final meal.
  final Meal meal;

  /// Shows a SnackBar message when a meal is added or removed from favorites.
  void _showInfoMessage(BuildContext context, bool isFavorite) {
    final message =
        isFavorite ? 'Meal added to favorites' : 'Meal removed from favorites';

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(favoritesProvider).contains(meal.id);
    final toggleFavorite = ref.read(favoritesProvider.notifier).toggleFavorite;

    return Scaffold(
        appBar: AppBar(
          title: Text(meal.title),
          actions: [
            IconButton(
                onPressed: () {
                  toggleFavorite(meal.id);
                  _showInfoMessage(context, !isFavorite);
                },
                icon: Icon(isFavorite ? Icons.star : Icons.star_border,
                    color: isFavorite
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.onSurface)
                //color: isFavorite ? Colors.orange : Colors.grey,),
                )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                meal.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 12,
              ),
              // copyWith is used to modify specific properties of titleLarge text style,
              // while still retaining the other default properties.
              Text(
                'List of Ingredients',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 14,
              ),
              for (final ingredient in meal.ingredients)
                Text(
                  ingredient,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Steps',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold),
              ),
              for (final step in meal.steps)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Text(
                    step,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ));
  }
}
