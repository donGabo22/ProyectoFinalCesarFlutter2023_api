// // navigation_example.dart
// import 'package:bbq_api/recipe_list_page.dart';
// import 'package:flutter/material.dart';

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
//           child: const Text('Page 1: Aquí debería abrir la página principal con un cardsweeper con una receta del día'),
//         ),
//         Container(
//           color: Colors.green,
//           alignment: Alignment.center,
//           child: const Text('Page 2: Aquí debería abrir todas las recetas en lista, [podemos agregar como plus aquí el ejemplo que había hecho de las categorías]'),
//         ),
//         RecipeListPage(), // Cambiado de RecipeListPageWithFilters a RecipeListPage
//         Container(
//           color: Colors.blue,
//           alignment: Alignment.center,
//           child: const Text('Page 3: Aquí debería abrir un buscador y filtros'),
//         ),
//       ][currentPageIndex],
//     );
//   }
// }
