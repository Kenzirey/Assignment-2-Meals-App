import 'package:meals_app/data/filter.dart';

class FilterProvider {
  static final Set<Filter> currentFilters = {};

  static final Set<Filter> availableFilters = {
    Filter.glutenFree,
    Filter.lactoseFree,
    Filter.vegan,
    Filter.vegetarian
  };

  static void addFilter(Filter newFilter) {
    currentFilters.add(newFilter);
  }

  static void removeFilter(Filter removedFilter) {
    currentFilters.remove(removedFilter);
  }

  static bool isOn(Filter filter) {
    return currentFilters.contains(filter);
  }

  static bool isFiltered(Set<Filter> filters) {
    return filters.containsAll(currentFilters);
  }
}