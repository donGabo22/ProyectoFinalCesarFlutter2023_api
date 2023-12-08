// recipe_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:bbq_api/models/meal.dart';
// recipe_detail_screen.dart
class RecipeDetailScreen extends StatelessWidget {
  final Meal meal;

  RecipeDetailScreen({required this.meal});

  @override
  Widget build(BuildContext context) {
    print('Meal JSON: $meal');
    print('Meal ID: ${meal.id}');
    print('Meal Title: ${meal.title}');
    print('Meal Ingredients: ${meal.ingredients}');
    print('Meal Instructions: ${meal.instructions}');

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(meal.thumbnail),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ingredients:'),
                  if (meal.ingredients.isNotEmpty)
                    for (String ingredient in meal.ingredients)
                      Text(ingredient),
                  SizedBox(height: 16.0),
                  Text('Instructions:'),
                  Text(meal.instructions),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}