// // recipe_list_page.dart
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
//   String _selectedCategory = 'Beef'; // Categoría predeterminada

//   @override
//   void initState() {
//     super.initState();
//     _loadMeals();
//   }

//   void _loadMeals() async {
//     try {
//       List<Meal> meals = await _mealService.getMealsByCategory(
//         category: _selectedCategory,
//       );
//       setState(() {
//         _meals = meals;
//       });
//     } catch (e) {
//       print('Error loading meals: $e');
//     }
//   }

//   void _filterByCategory(String category) {
//     setState(() {
//       _selectedCategory = category;
//       _loadMeals();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.green,
//       alignment: Alignment.center,
//       child: Column(
//         children: [
//           DropdownButton<String>(
//             value: _selectedCategory,
//             items: <String>['Beef', 'Chicken', 'Dessert', 'Seafood']
//                 .map((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(value),
//               );
//             }).toList(),
//             onChanged: (String? newValue) {
//               if (newValue != null) {
//                 _filterByCategory(newValue);
//               }
//             },
//           ),
//           _meals.isNotEmpty
//               ? Expanded(
//                   child: ListView.builder(
//                     itemCount: _meals.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         title: Text(_meals[index].title),
//                         subtitle: Text(_meals[index].category),
//                         leading: Image.network(_meals[index].thumbnail),
//                       );
//                     },
//                   ),
//                 )
//               : const Text('No recipes found.'),
//         ],
//       ),
//     );
//   }
// }


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
    return Container(
      color: Colors.green,
      alignment: Alignment.center,
      child: Column(
        
        children: [
             const Text(
                'Buscas algo en especial!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
          
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
              : const Text('No recipes found.'),
        ],
      ),
    );
  }
}

