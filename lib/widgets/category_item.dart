import 'package:flutter/material.dart';

import '../screens/category_meal_screen.dart';
import '../Dummy_data.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  CategoryItem({
    this.id,
    this.title,
    this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          Navigator.of(context)
              .pushNamed(CategoryMealsScreen.routeName, arguments: {
            'id': id,
            'title': title,
          });
        },
        splashColor: color,
        child: Container(
          padding: EdgeInsets.all(10),
          // margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.6),
                color,
              ],
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
