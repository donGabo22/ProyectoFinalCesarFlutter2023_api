// import 'package:flutter/material.dart';
// import 'package:bbq_api/models/meal.dart';
// import 'package:bbq_api/services/meal_service.dart';

// class RecipeListPage extends StatefulWidget {
//   @override
//   _RecipeListPageState createState() => _RecipeListPageState();
// }

// class _RecipeListPageState extends State<RecipeListPage> {
//   final MealService _mealService = MealService();
//   List<Meal> _meals = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadMeals();
//   }

//   void _loadMeals() async {
//     try {
//       List<Meal> meals = await _mealService.getMealsByCategory('Beef'); // Cambia 'Beef' por la categoría que desees
//       setState(() {
//         _meals = meals;
//       });
//     } catch (e) {
//       print('Error al cargar las meals: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.green,
//       alignment: Alignment.center,
//       child: _meals.isNotEmpty
//           ? ListView.builder(
//               itemCount: _meals.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(_meals[index].title),
//                   subtitle: Text(_meals[index].category),
//                   leading: Image.network(_meals[index].thumbnail),
//                 );
//               },
//             )
//           : const Text('No se encontraron recetas.'),
//     );
//   }
// }

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

  @override
  void initState() {
    super.initState();
    _loadMeals();
  }

  void _loadMeals() async {
    try {
      List<Meal> meals =
          await _mealService.getMealsByCategory(_selectedCategory);
      setState(() {
        _meals = meals;
      });
    } catch (e) {
      print('Error al cargar las meals: $e');
    }
  }

  void _filterByCategory(String category) {
    setState(() {
      _selectedCategory = category;
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
          // Agregamos un botón para filtrar por categoría
          DropdownButton<String>(
            value: _selectedCategory,
            items: <String>[
              'Beef',
              'Chicken',
              'Dessert',
              'Seafood'
            ] // Puedes agregar más categorías
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
