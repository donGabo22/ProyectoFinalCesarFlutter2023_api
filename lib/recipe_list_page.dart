// recipe_list_page.dart
import 'package:flutter/material.dart';
import 'package:bbq_api/models/meal.dart';
import 'package:bbq_api/services/meal_service.dart';

class RecipeListPage extends StatefulWidget {
  @override
  _RecipeListPageState createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {
  final MealService _mealService = MealService();
  List<Meal> _meals = [];
  String _selectedCategory = 'Beef'; // Categoría predeterminada
  List<String> _areas = ['Any']; // Áreas (países) disponibles
  String _selectedArea = 'Any'; // Área (país) predeterminado

  @override
  void initState() {
    super.initState();
    _loadMeals();
    _loadAreas();
  }

  void _loadMeals() async {
    try {
      List<Meal> meals = await _mealService.getMealsByCategoryAndArea(
        category: _selectedCategory,
        area: _selectedArea,
      );
      setState(() {
        _meals = meals;
      });
    } catch (e) {
      print('Error al cargar las meals: $e');
    }
  }

  void _loadAreas() async {
    try {
      List<String> areas = await _mealService.getAreasList();
      setState(() {
        _areas = ['Any', ...areas];
      });
    } catch (e) {
      print('Error al cargar las áreas: $e');
    }
  }

  void _filterByCategory(String category) {
    setState(() {
      _selectedCategory = category;
      _loadMeals();
    });
  }

  void _filterByArea(String area) {
    setState(() {
      _selectedArea = area;
      _loadMeals();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      alignment: Alignment.center,
      child: Column(
        children: [
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
          DropdownButton<String>(
            value: _selectedArea,
            items: _areas.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                _filterByArea(newValue);
              }
            },
          ),
          _meals.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: _meals.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_meals[index].title),
                        subtitle: Text(_meals[index].category),
                        leading: Image.network(_meals[index].thumbnail),
                      );
                    },
                  ),
                )
              : const Text('No se encontraron recetas.'),
        ],
      ),
    );
  }
}
