import 'package:flutter/material.dart';

class temporal_page extends StatelessWidget {
  const temporal_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('En Construcción', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black.withOpacity(1),
      ),
      body: Stack(
        children: [
          // Fondo GIF
          Positioned.fill(
            child: Image.asset(
              "assets/others/background_JD.gif",
              fit: BoxFit.cover,
            ),
          ),
          // Contenido
          Center(
            child: Text(
              'Esta página está en construcción.',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
