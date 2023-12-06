// import 'package:bbq_api/recipe_list_page.dart';
// import 'package:flutter/material.dart';

// void main() => runApp(const NavigationBarApp());

// class NavigationBarApp extends StatelessWidget {
//   const NavigationBarApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(home: NavigationExample());
//   }
// }

// class NavigationExample extends StatefulWidget {
//   const NavigationExample({Key? key}) : super(key: key);

//   @override
//   State<NavigationExample> createState() => _NavigationExampleState();
// }

// class _NavigationExampleState extends State<NavigationExample> {
//   int currentPageIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: NavigationBar(
//         onDestinationSelected: (int index) {
//           setState(() {
//             currentPageIndex = index;
//           });
//         },
//         indicatorColor: Colors.amber[800],
//         selectedIndex: currentPageIndex,
//         destinations: const <Widget>[
//           NavigationDestination(
//             selectedIcon: Icon(Icons.home),
//             icon: Icon(Icons.home_outlined),
//             label: 'Página Principal',
//           ),
//           NavigationDestination(
//             icon: Icon(Icons.receipt),
//             label: 'Recetas',
//           ),
//           NavigationDestination(
//             selectedIcon: Icon(Icons.search),
//             icon: Icon(Icons.school_outlined),
//             label: 'Buscar',
//           ),
//         ],
//       ),
//       body: <Widget>[
//         Container(
//           color: Colors.red,
//           alignment: Alignment.center,
//           child: const Text(
//               'Page 1: Aquí debería abrir la página principal con un cardsweeper con una receta del día'),
//         ),
//         RecipeListPage(),
//         Container(
//           color: Colors.blue,
//           alignment: Alignment.center,
//           child: const Text('Page 3: Aquí debería abrir un buscador y filtros'),
//         ),
//       ][currentPageIndex],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:bbq_api/models/meal.dart';
import 'package:bbq_api/services/meal_service.dart';

void main() => runApp(const NavigationBarApp());

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NavigationExample());
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({Key? key}) : super(key: key);

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber[800],
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Página Principal',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt),
            label: 'Recetas',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.search),
            icon: Icon(Icons.school_outlined),
            label: 'Buscar',
          ),
        ],
      ),
      body: <Widget>[
        Container(
          color: Colors.red,
          alignment: Alignment.center,
          child: const Text('Page 1: Aquí debería abrir la página principal con un cardsweeper con una receta del día'),
        ),
        RecipeListPage(), // La página 2 muestra la lista de recetas
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Text('Page 3: Aquí debería abrir un buscador y filtros'),
        ),
      ][currentPageIndex],
    );
  }
}

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
      List<Meal> meals = await _mealService.getMealsByCategory(_selectedCategory);
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
            items: <String>['Beef', 'Chicken', 'Dessert','Seafood'] // Puedes agregar más categorías
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





