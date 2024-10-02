import 'package:flutter/material.dart';
import 'login_page.dart';
import '../util/background_painter.dart'; // Importa el CustomPainter

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo con CustomPainter
          CustomPaint(
            size: Size.infinite,
            painter: BackgroundPainter(),
          ),
          // Contenido
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  "assets/icons/logo_png.png",
                  width: 200,
                  height: 200,
                  errorBuilder: (context, error, stackTrace) {
                    return Text('Error al cargar la imagen: $error', style: const TextStyle(color: Colors.white));
                  },
                ),

                const SizedBox(height: 1),

                // Título
                const Text(
                  'Bienvenido',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                // Subtítulo
                const Text(
                  'Control de Recompensas',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 40),

                // Botón de Inicio
                ElevatedButton.icon(
                  onPressed: () {
                    // Navegar a la LoginPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  icon: const Icon(Icons.login, color: Colors.white),
                  label: const Text(
                    'Ingresar Sus Credenciales',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(148, 58, 58, 109),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Olvidó su contraseña
                TextButton(
                  onPressed: () {
                    // Acción para olvidó su contraseña
                  },
                  child: const Text(
                    'Olvidó su contraseña?',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
