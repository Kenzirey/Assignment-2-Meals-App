import 'package:meals_app/data/filter.dart';

/// Used as global storage and utility class for filters.
/// Keeps track of which filters are currently active, and
/// and allows for easily checking the state of filters.
class FilterProvider {
  /// A list of all filters that should be included in the application.
  /// Used for potentially not including Work in Progress filters.
  static const Set<Filter> availableFilters = {
    Filter.glutenFree,
    Filter.lactoseFree,
    Filter.vegan,
    Filter.vegetarian
  };

  /// Keeps track of which filters are currently active
  static final Set<Filter> currentFilters = {};

  /// Applies a new filter to the filter provider.
  ///
  /// See [Set.add]
  static void addFilter(Filter newFilter) {
    currentFilters.add(newFilter);
  }

  /// Removes a filter from the filter provider.
  /// Does nothing if the filter is not currently in the list.
  ///
  /// See [Set.remove]
  static void removeFilter(Filter removedFilter) {
    currentFilters.remove(removedFilter);
  }

  /// Checks if [filter] is currently applied.
  static bool isOn(Filter filter) {
    return currentFilters.contains(filter);
  }

  /// Compares a set of [filters] to the currently applied filters in order
  /// to determine whether the item should be allowed through the filters.
  /// Returns false if the input [filters] would be filtered out by the currently applied filters.
  static bool passesFilter(Set<Filter> filters) {
    return filters.containsAll(currentFilters);
  }
}