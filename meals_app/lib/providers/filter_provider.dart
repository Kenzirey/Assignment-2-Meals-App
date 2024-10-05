import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/filter.dart';
import 'package:meals_app/persistence/filter_persistency.dart';

/// Provides access to the filter provider. (Riverpod)
final filterProvider =
    StateNotifierProvider<FilterProvider, Set<Filter>>((ref) {
  return FilterProvider();
});

/// Used as global storage and utility class for filters.
/// Keeps track of which filters are currently active, and
/// and allows for easily checking the state of filters.
class FilterProvider extends StateNotifier<Set<Filter>> {
  /// A list of all filters that should be included in the application.
  /// Used for potentially not including Work in Progress filters.
  static const Set<Filter> availableFilters = {
    Filter.glutenFree,
    Filter.lactoseFree,
    Filter.vegan,
    Filter.vegetarian
  };

  // 🤷‍♂️🤷‍♀️
  FilterProvider() : super({}) {
    loadFromPersistence();
  }

  void loadFromPersistence() async {
    state = await filterPersistency.load();
  }

  /// Keeps track of which filters are currently active
  static final Set<Filter> currentFilters = {};

  /// Applies a new filter to the filter provider.
  ///
  /// See [Set.add]
  void addFilter(Filter newFilter) {
    state = {...state, newFilter};
    filterPersistency.save(state);
  }

  /// Removes a filter from the filter provider.
  /// Does nothing if the filter is not currently in the list.
  ///
  /// See [Set.remove]
  void removeFilter(Filter removedFilter) {
    state = state.where((item) => item != removedFilter).toSet();
    filterPersistency.save(state);
  }

  /// Overwrites the current filters of the filter provider with [filters]
  void setFilters(Set<Filter> filters) {
    state = filters;
  }

  /// Checks if [filter] is currently applied.
  bool isOn(Filter filter) {
    return state.contains(filter);
  }

  /// Compares a set of [filters] to the currently applied filters in order
  /// to determine whether the item should be allowed through the filters.
  /// Returns false if the input [filters] would be filtered out by the currently applied filters.
  bool passesFilter(Set<Filter> filters) {
    // Only return true if the meal's filters contain all the active filters.
    return state.every((activeFilter) => filters.contains(activeFilter));
  }
}
