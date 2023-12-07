import 'package:bbq_api/card_swiper.dart';
import 'package:bbq_api/recipe_list_page.dart';
import 'package:flutter/material.dart';
import 'package:bbq_api/services/meal_service.dart';
import 'package:bbq_api/models/meal.dart';

void main() => runApp(const NavigationBarApp());

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const NavigationExample(),
      debugShowCheckedModeBanner: false, // Oculta el banner de debug
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({Key? key}) : super(key: key);

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;
  MealService _mealService = MealService();
  List<Meal> _randomMeals = [];

  @override
  void initState() {
    super.initState();
    _loadRandomMeals();
  }

  void _loadRandomMeals() async {
    try {
      List<Meal> allMeals = await _mealService.getAllMeals();
      setState(() {
        _randomMeals = allMeals;
      });
    } catch (e) {
      print('Error loading all meals: $e');
    }
  }

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
        // Página Principal (Index 0)
        Container(
          color: Colors.green,
          alignment: Alignment.center, // Centro vertical y horizontal
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '¡Bienvenido!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              CardSwiper(meals: _randomMeals),
            ],
          ),
        ),
      
        // Página de Recetas (Index 1)
        RecipeListPage(),
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Text('Page 3: Aquí debería abrir un buscador y filtros'),
        ),
      ][currentPageIndex],
    );
  }
}
