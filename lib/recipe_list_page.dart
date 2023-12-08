// recipe_list_page.dart
import 'package:bbq_api/services/meal_service.dart';
import 'package:flutter/material.dart';
import 'package:bbq_api/models/meal.dart';
import 'recipe_detail_screen.dart';


class RecipeListPage extends StatefulWidget {
  @override
  _RecipeListPageState createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {
  final MealService _mealService = MealService();
  List<Meal> _meals = [];
  String _selectedCategory = 'Beef';

  @override
  void initState() {
    super.initState();
    _loadMeals();
  }

  void _loadMeals() async {
    try {
      List<Meal> meals;
      if (_selectedCategory == 'Random') {
        meals = await _mealService.getRandomMealsBatch(10);
      } else {
        meals = await _mealService.getMealsByCategory(
          category: _selectedCategory,
        );
      }

      setState(() {
        _meals = meals;
      });
    } catch (e) {
      print('Error loading meals: $e');
    }
  }

  void _filterByCategory(String category) {
    setState(() {
      _selectedCategory = category;
      if (_selectedCategory != 'Random') {
        _loadMeals();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe List'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            const Text(
              'Buscas algo en especial!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            DropdownButton<String>(
              value: _selectedCategory,
              items: <String>['Beef', 'Chicken', 'Dessert', 'Seafood']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  _filterByCategory(newValue);
                }
              },
            ),
            const SizedBox(height: 8.0),
            _meals.isNotEmpty
                ? Container(
                    height: MediaQuery.of(context).size.height - 240.0,
                    child: ListView.builder(
                      itemCount: _meals.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                          title: Text(_meals[index].title),
                          subtitle: Text(_meals[index].category),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              _meals[index].thumbnail,
                              height: 80.0, // Ajusta la altura según sea necesario
                              width: 80.0, // Ajusta el ancho según sea necesario
                            ),
                          ),
                          onTap: () {
                            _navigateToRecipeDetail(_meals[index]);
                          },
                        );
                      },
                    ),
                  )
                : const Text('No recipes found.'),
          ],
        ),
      ),
    );
  }

  void _navigateToRecipeDetail(Meal meal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeDetailScreen(meal: meal),
      ),                                                                                                        
    );
  }
}
