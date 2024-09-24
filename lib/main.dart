import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF6A1B9A), // Color de fondo púrpura
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Icon(Icons.whatshot, size: 100, color: Colors.orangeAccent), // Puedes usar un icono de fuego

            SizedBox(height: 20),

            // Título
            Text(
              'Login to Start',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            // Subtítulo
            Text(
              'Test your app development knowledge with quick bite-sized quizzes.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),

            SizedBox(height: 40),

            // Botón de Google
            ElevatedButton.icon(
              onPressed: () {
                // Acción de login con Google
              },
              icon: Icon(Icons.g_mobiledata, color: Colors.white),
              label: Text(
                'Login with Google',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // Color del botón
                minimumSize: Size(double.infinity, 50), // Ancho completo
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            SizedBox(height: 20),

            // Botón de Apple
            ElevatedButton.icon(
              onPressed: () {
                // Acción de login con Apple
              },
              icon: Icon(Icons.apple, color: Colors.white),
              label: Text(
                'Sign in with Apple',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Color del botón
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            SizedBox(height: 20),

            // Continuar como invitado
            TextButton(
              onPressed: () {
                // Acción para continuar como invitado
              },
              child: Text(
                'Continue as Guest',
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
