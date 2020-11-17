import 'package:flutter/material.dart';

import '../const.dart';
import '../models/meals.dart';
import '../widgets/meals_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  CategoryMealsScreen(this.availableMeals);
  static const routeName = '/category-meal';
  final List<Meal> availableMeals;

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  var loadedInitData = false;
  String categoryTitle;
  List<Meal> displayedMeals = [];

  @override
  void didChangeDependencies() {
    if (!loadedInitData) {
      final category =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      final categoryId = category['id'];
      categoryTitle = category['title'];
      displayedMeals = widget.availableMeals
          .where(
            (meal) => meal.categories.contains(categoryId),
          )
          .toList();
      loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, i) {
          return MealItem(
            id: displayedMeals[i].id,
            title: displayedMeals[i].title,
            imageUrl: displayedMeals[i].imageUrl,
            duration: displayedMeals[i].duration,
            complexity: displayedMeals[i].complexity,
            affordability: displayedMeals[i].affordability,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
