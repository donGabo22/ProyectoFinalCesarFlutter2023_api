// main.dart
import 'package:bbq_api/recipe_list_page.dart';
import 'package:flutter/material.dart';

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
          child: const Text(
              'Page 1: Aquí debería abrir la página principal con un cardsweeper con una receta del día'),
        ),
        RecipeListPage(), //pag 2
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Text('Page 3: Aquí debería abrir un buscador y filtros'),
        ),
      ][currentPageIndex],
    );
  }
}
