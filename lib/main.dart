import 'package:bbq_api/recipe_list_page.dart';
import 'package:flutter/material.dart';
import 'package:bbq_api/firebase/login_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(
        onAuthenticate: (String email, String password) {},
        onRegister: (String email, String password) {},
      ),
      debugShowCheckedModeBanner: false,
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
            selectedIcon: Icon(Icons.favorite_border_outlined),
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
        ],
      ),
      body: <Widget>[
        Container(
          color: Colors.orange,
          alignment: Alignment.center,
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
              // Agrega aquí tu contenido de la pantalla de inicio
            ],
          ),
        ),
        RecipeListPage(),
        Container(
          color: Colors.orange,
          alignment: Alignment.center,
          child: const Text(
              'Page 3: Aquí debería consumir las recientes o favoritos o algo así'),
        ),
      ][currentPageIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return LoginScreen(
                onAuthenticate: (String email, String password) {},
                onRegister: (String email, String password) {},
              );
            },
          );
        },
        child: Icon(Icons.login),
        backgroundColor: Colors.brown,
      ),
    );
  }
}
