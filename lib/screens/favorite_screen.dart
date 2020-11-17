import 'package:flutter/material.dart';

import '../models/meals.dart';
import '../widgets/meals_item.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen(this.favMeals);

  final List<Meal> favMeals;

  @override
  Widget build(BuildContext context) {
    if (favMeals.isEmpty) {
      return Center(
        child: Text('Empty'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favMeals[index].id,
            title: favMeals[index].title,
            imageUrl: favMeals[index].imageUrl,
            duration: favMeals[index].duration,
            complexity: favMeals[index].complexity,
            affordability: favMeals[index].affordability,
          );
        },
        itemCount: favMeals.length,
      );
    }
  }
}
