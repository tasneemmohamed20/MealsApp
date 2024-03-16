import 'package:flutter/material.dart';
import 'package:meals_app/Screens/meals.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/categories_model.dart';
import 'package:meals_app/models/meals_model.dart';
import 'package:meals_app/widgets/grid_item.dart';

class Categories extends StatelessWidget {
  const Categories(
      {super.key,
      // required this.onToggleFavourite,
      required this.availableMeals});

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MealsScreen(
              title: category.title,
              meals: filteredMeals,
              // onToggleFavourite: onToggleFavourite,
            )));
  }

  // final void Function(Meal meal) onToggleFavourite;
  final List<Meal> availableMeals;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Pick your category'),
      // ),
      body: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            GridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            )
        ],
      ),
    );
  }
}
