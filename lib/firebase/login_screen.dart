import 'package:flutter/material.dart';
import 'register_screen.dart';


class LoginScreen extends StatefulWidget {
  final Function(String, String) onAuthenticate;
  final Function(String, String) onRegister;

  LoginScreen({required this.onAuthenticate, required this.onRegister});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange, // Fondo naranja
      appBar: AppBar(
        title: Text('Iniciar Sesión'),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          margin: EdgeInsets.all(16.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white, // Fondo blanco
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.restaurant_menu,
                size: 80.0,
                color: Colors.brown,
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Correo Electrónico',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Lógica de autenticación aquí
                  widget.onAuthenticate(
                    _emailController.text.trim(),
                    _passwordController.text.trim(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.brown, // Fondo marrón
                  onPrimary: Colors.white, // Texto blanco
                ),
                child: Text('Iniciar Sesión'),
              ),
              SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return RegisterScreen(
                        onRegister: widget.onRegister,
                      );
                    },
                  );
                },
                style: TextButton.styleFrom(
                  primary: Colors.brown, // Texto marrón
                ),
                child: Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}