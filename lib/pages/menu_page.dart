import 'package:flutter/material.dart';
import 'profile_page.dart'; // Importa la nueva página de perfil
import '../api_connection/api_service.dart'; // Importa tu servicio API
import 'historialVentas_page.dart';

class MenuPage extends StatelessWidget {
  final Tecnico tecnico; // Añadido

  const MenuPage({Key? key, required this.tecnico}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF021526),
              ),
              child: Text(
                'Navegación',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Ver Perfil'),
              onTap: () async {
                Navigator.pop(context);
                // Navegar a la página de perfil
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(
                      tecnico: tecnico, // Pasar el objeto Tecnico completo
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Historial de Ventas Intermediadas'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HistorialVentasPage(idTecnico: tecnico.idTecnico), // Pasar el idTecnico
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Historial de Canjes'),
              onTap: () {
                // Navegar a la página de historial de canjes
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(
                      tecnico: tecnico, // Pasar el objeto Tecnico completo
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // Dos botones por fila
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: [
            _buildMenuButton(context, 'Ver Perfil', Icons.person, () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(
                      tecnico: tecnico, // Pasar el objeto Tecnico completo
                    ),
                  ),
                );
            }),
            _buildMenuButton(context, 'Historial de Ventas Intermediadas', Icons.history, () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HistorialVentasPage(idTecnico: tecnico.idTecnico), // Pasar el idTecnico
                  ),
                );
            }),
            _buildMenuButton(context, 'Historial de Canjes', Icons.swap_horiz, () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(
                      tecnico: tecnico, // Pasar el objeto Tecnico completo
                    ),
                  ),
                );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String title, IconData icon, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF3B82F6), // Color del botón
        padding: EdgeInsets.symmetric(vertical: 20),
        textStyle: TextStyle(fontSize: 20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.white), // Icono del botón
          const SizedBox(height: 10),
          Text(title, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
