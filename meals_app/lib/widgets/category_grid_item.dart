import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/category.dart';

/// A widget for displaying categories of meals in a grid.
/// Has touch functionality with visual feedback.
///
/// While also displaying amount of meals per category.
class CategoryGridItem extends ConsumerWidget {
  const CategoryGridItem({
    super.key,
    required this.category,
    required this.onSelectCategory,
  });

  final Category category;
  final void Function() onSelectCategory;

  @override
  Widget build(BuildContext context, WidgetRef ref) { // Added ref for the getNumMealsVisible.
    final int availableMeals = category.getNumMealsVisibleInCategory(ref);

    final bool anyMeals = availableMeals > 0;
    final String availableMsg = "${anyMeals ? availableMeals : "None"} available";
    final int displayTextAlpha = anyMeals ? 255 : 200;

    /// Returns the color gradient for the category grid item,
    /// based on whether the category is empty or not.
    List<Color> getDisplayGradient() {
      if (anyMeals) {
        return [
          category.color.withOpacity(0.55),
          category.color.withOpacity(0.9),
        ];
      }
      return [
        Colors.grey.shade600.withOpacity(0.55),
        Colors.grey.shade600.withOpacity(0.55),
      ];
    }

    /// Opens a category of meals if it's not empty.
    void tryOpenCategory() {
      if (anyMeals) {
        onSelectCategory();
      }
    }

    // InkWell is a rectangular area of (Material app) that responds to touch.
    // Also gives feedback! GestureDetector does not give nice feedback.
    return InkWell(
      onTap: tryOpenCategory,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: getDisplayGradient(),
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        // Stack allows for multiple visual elemens to be displayed within a "stack".
        child: Stack(
          children: [
            Text(
              category.title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withAlpha(displayTextAlpha),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                availableMsg,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withAlpha(200),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
