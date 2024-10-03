import 'package:flutter/material.dart';
import 'package:meals_app/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    super.key,
    required this.category,
    required this.onSelectCategory,
  });

  final Category category;
  final void Function() onSelectCategory;

  int get _available => category.getNumMealsVisibleInCategory();
  bool get _anyMeals => _available > 0;
  String get _availableMsg => "${_anyMeals ? _available : "None"} available";
  int get _displayTextAlpha => _anyMeals ? 255 : 200;
  List<Color> get _displayGradient {
    if (_anyMeals) {
      return [
        category.color.withOpacity(0.55),
        category.color.withOpacity(0.9)
      ];
    }
    return [
      Colors.grey.shade600.withOpacity(0.55),
      Colors.grey.shade600.withOpacity(0.55)
    ];
  }

  void _tryOpenCategory() {
    if (_anyMeals) {
      onSelectCategory();
    }
  }

  @override
  Widget build(BuildContext context) {
    // InkWell is a rectangular area of (Material app) that responds to touch.
    // Also gives feedback! GestureDetector does not give nice feedback.
    return InkWell (
      // Back arrow is added automatically by flutter, not by us.
      onTap: _tryOpenCategory,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: _displayGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Text(
              category.title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withAlpha(_displayTextAlpha),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                _availableMsg,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(200),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
