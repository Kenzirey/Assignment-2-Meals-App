import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/providers/meal_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

/// Widget that manages tabbed screen navigation.
/// Allows user to switch between "Favorites"- and "Categories" screen,
/// through a bottom navigation bar.
class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

/// The state for [TabsScreen].
///
/// Manages currently selected tab,
/// while updating UI to show the corresponding screen.
class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  // Used for the main drawer to keep track of the screens 🤷‍♀️
  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      bool? didChange = await Navigator.of(context).push<bool>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );

      if (didChange ?? false) {
        setState((){});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Access all meals (currently from dummy data) via the meal provider.
    final allMeals = ref.watch(mealsProvider);
    // Access the favorite meals via the favorites provider (riverpod).
    final favoriteMealIds = ref.watch(favoritesProvider);


    // Map meal IDs to actual Meal objects using the meals list from mealProvider.
    final favoriteMeals = allMeals.where((meal) {
      return favoriteMealIds.contains(meal.id);
    }).toList();


    Widget activePage = const CategoriesScreen();
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: favoriteMeals,
      );
      activePageTitle = 'Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
