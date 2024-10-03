/// Conditions that can be used to filter out specific meals
enum Filter {
  glutenFree(
    "Gluten Free",
    "Only show gluten-free meals"
  ),
  lactoseFree(
    "Lactose Free",
    "Only show lactose-free meals"
  ),
  vegetarian(
    "Vegetarian",
    "Only show vegetarian meals"
  ),
  vegan(
    "Vegan",
    "Only show vegan meals"
  );

  final String title;
  final String? subtitle;

  /// Creates a new filter with a title and an optional subtitle.
  ///
  /// [title] should be the name of the filter itself, whilst the [subtitle] should be a brief
  /// description thereof.
  const Filter(this.title, this.subtitle);
}