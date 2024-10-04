import 'package:flutter/material.dart';

/// Widget for displaying an icon and a label for describing
/// the trait of a meal item.
class MealItemTrait extends StatelessWidget {
  const MealItemTrait({
    super.key,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.white),
        const SizedBox(width: 6,),
        Text(label,
        style: const TextStyle(
          color: Colors.white
        ),),
      ],
    );
  }
}
