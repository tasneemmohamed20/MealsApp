import 'package:flutter/material.dart';
import 'package:meals_app/Screens/categories.dart';
import 'package:meals_app/Screens/filters.dart';
import 'package:meals_app/Screens/meals.dart';
// import 'package:meals_app/data/dummy_data.dart';
// import 'package:meals_app/models/meals_model.dart';
import 'package:meals_app/widgets/main_drawer.dart';
// import 'package:meals_app/providers/meals_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/fav_provider.dart';
import 'package:meals_app/providers/filters_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});
  @override
  ConsumerState<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends ConsumerState<TabScreen> {
  // Map<Filter, bool> _selectFilters = kInitialFilters;
  int _selectedPageIndex = 0;

  // void _toggleMealFavouriteStates(Meal meal) {
  //   final isExisting = favMeals.contains(meal);
  //   if (isExisting == true) {
  //     setState(() {
  //       _favouriteMeals.remove(meal);
  //     });
  //     _showInfoMessage('Meal is no longer a favourite');
  //   } else {
  //     setState(() {
  //       _favouriteMeals.add(meal);
  //     });
  //     _showInfoMessage('Marked as a favourite!');
  //   }
  // }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'Filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(
              // currentFilters: _selectFilters,
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    // final meals = ref.watch(mealsProvider); //listener
    final availableMeals = ref.watch(filteredMealProvider);
    // final activeFilters = ref.watch(filterProvider);
    // final availableMeals =
    Widget activePage = Categories(
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';
    if (_selectedPageIndex == 1) {
      final favMeals = ref.watch(favMealsProvider);
      activePage = MealsScreen(
        meals: favMeals,
      );
      activePageTitle = 'Favourites';
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
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
