import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/filter.dart';
import 'package:meals_app/providers/filter_provider.dart';

/// Allows the user to toggle on/off filters that affect which meals will be shown.
/// Keeps track of changes by the user, to dynamically update the list of applied filters,
/// through the use of Riverpod.
class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({super.key});


  @override
  ConsumerState<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

/// The state for [FiltersScreen], which manages the user's interaction with the filters.
/// 
/// Keeps track of which filters are currently enabled or disabled.
class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  bool didChange = false;
  Set<Filter> oldFilters = {};

  @override
  initState() {
    // Setting up a copy of the filters for comparison to see
    // if anything has changed.
    oldFilters = ref.read(filterProvider).toSet();
    super.initState();
  }

  // Creates toggle buttons for all available filters.
  Widget _filterButtons() {

    final currentFilters = ref.watch(filterProvider);  // Listen to changes.
    final filterNotifier = ref.read(filterProvider.notifier);  // Access to update the filters.

    return Column(
      children: [
        for (Filter filter in FilterProvider.availableFilters)
          SwitchListTile(
            value: currentFilters.contains(filter),
            onChanged: (bool isChecked) {
              setState(() {
                if (isChecked) {
                  filterNotifier.addFilter(filter);
                } else {
                  filterNotifier.removeFilter(filter);
                }

                // Performing an in-depth check to minimize state refreshes.
                // If the end result is that nothing has changed, a state refresh shouldn't happen.
                // Compare current filters to old filters to detect changes
                didChange = !setEquals(currentFilters, oldFilters);
              });
            },
            title: Text(
              filter.title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            subtitle: Text(
              filter.subtitle ?? "",
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          if (didPop) return;
          Navigator.of(context).pop(didChange);
        },
        child: _filterButtons()
      ),
    );
  }
}
