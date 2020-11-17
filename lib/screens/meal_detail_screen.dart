import 'package:flutter/material.dart';

import '../const.dart';
import '../Dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  MealDetailScreen(this.isFav, this.toogleFav);
  final Function isFav;
  final Function toogleFav;

  Widget _buildIng(BuildContext context, List<String> ing) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kAccentColor.withOpacity(0.3),
        border: Border.all(
          width: 2,
          color: kPrimaryColor,
        ),
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
      child: ListView.builder(
        itemCount: ing.length,
        itemBuilder: (ctx, i) => Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: kPrimaryColor,
          ),
          // width: double.infinity,
          // height: 30,
          child: Text(
            ing[i],
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStep(BuildContext context, List<String> step) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        border: Border.all(
          width: 2,
          color: kAccentColor.withOpacity(0.7),
        ),
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
      child: ListView.builder(
        itemCount: step.length,
        itemBuilder: (ctx, i) => Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: kAccentColor.withOpacity(0.7),
          ),
          // width: double.infinity,
          // height: 30,
          child: Text(
            '${i + 1}).  ${step[i]}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildText(String text) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final mealId = routeArgs['id'];
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    print(mealId);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Card(
                shadowColor: kPrimaryColor,
                margin: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 10,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kBackgroundColor,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(),
                      Positioned(
                        left: -15,
                        // top: -8,
                        // bottom: 0,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Text(
                        selectedMeal.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: kTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    selectedMeal.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              _buildText('Ingredients'),
              _buildIng(
                context,
                selectedMeal.ingredients,
              ),
              _buildText('Steps'),
              _buildStep(
                context,
                selectedMeal.steps,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kTextColor,
        onPressed: () => toogleFav(mealId),
        child: Icon(
          isFav(mealId) ? Icons.star : Icons.star_border,
          size: isFav(mealId) ? 35 : 30,
          color: kBackgroundColor,
        ),
      ),
    );
  }
}
