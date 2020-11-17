import 'package:Be_a_chef/Dummy_data.dart';
import 'package:flutter/material.dart';

import './const.dart';
import './models/meals.dart';
import './screens/tabs_screen.dart';
import './screens/category_meal_screen.dart';
import './screens/meal_detail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'isVegan': false,
    'isVegetarian': false,
  };
  List<Meal> _favoriteMeals = [];
  List<Meal> _availableMeals = DUMMY_MEALS;

  void _setFilter(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where(
        (meal) {
          if (_filters['gluten'] && !meal.isGlutenFree) {
            return false;
          }
          if (_filters['lactose'] && !meal.isLactoseFree) {
            return false;
          }
          if (_filters['isVegan'] && !meal.isVegan) {
            return false;
          }
          if (_filters['isVegetarian'] && !meal.isVegetarian) {
            return false;
          }
          return true;
        },
      ).toList();
    });
  }

  void _toogleFav(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: kPrimarySwatch,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(_favoriteMeals, _setFilter, _filters),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_isMealFavorite, _toogleFav),
        // FiltersScreen.routeName: (ctx) => FiltersScreen(_setFilter),
      },
    );
  }
}

const MaterialColor kPrimarySwatch = const MaterialColor(
  0xFFFEB9B9,
  <int, Color>{
    50: const Color(0xFFFEB9B9),
    100: const Color(0xFFFEB9B9),
    200: const Color(0xFFFEB9B9),
    300: const Color(0xFFFEB9B9),
    400: const Color(0xFFFEB9B9),
    500: kPrimaryColor,
    600: const Color(0xFFFEB9B9),
    700: const Color(0xFFFEB9B9),
    800: const Color(0xFFFEB9B9),
    900: const Color(0xFFFEB9B9),
  },
);
