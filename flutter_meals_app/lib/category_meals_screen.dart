import 'package:flutter/material.dart';

import './data/dummy_meal_data.dart';
import './models/meal.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = "/category-meals";
  // final String categoryId;
  // final String categoryTitle;
  CategoryMealsScreen();

  @override
  Widget build(BuildContext context) {
    final routedArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryTitle = routedArgs['title'];
    final categoryId = routedArgs['id'];
    final categoryMeals = DUMMY_MEALS
        .where((meal) => meal.categories.contains(categoryId))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return Text(categoryMeals[index].title);
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
