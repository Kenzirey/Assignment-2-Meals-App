import 'package:flutter/material.dart';
import 'package:meals_app/data/filter.dart';
import 'package:meals_app/providers/filter_provider.dart';
/* import 'package:meals_app/screens/tabs.dart';
import 'package:meals_app/widgets/main_drawer.dart'; */

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool didChange = false;

  Widget _filterButtons() {
    return Column(
      children: [
        for (Filter filter in FilterProvider.availableFilters)
          SwitchListTile(
            value: FilterProvider.isOn(filter),
            onChanged: (bool isChecked) {
              setState(() {
                if (isChecked) {
                  FilterProvider.addFilter(filter);
                } else {
                  FilterProvider.removeFilter(filter);
                }
                didChange = true;
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
      /* drawer: MainDrawer(onSelectScreen: (identifier) {
        Navigator.of(context).pop();
        if (identifier == 'meals') {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const TabsScreen(),),);
        }
      }), */
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
