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

  const Filter(this.title, this.subtitle);
}