import 'package:flutter/material.dart';
import 'profile_page.dart'; 
import 'historialVentas_page.dart';
import '../../data/models/tecnico.dart';
import 'package:provider/provider.dart';
import '../../logic/login_bloc.dart'; // Asegúrate de importar tu LoginBloc

class MenuPage extends StatelessWidget {
  
  final Tecnico tecnico;  // Ya recibes el técnico aquí

  const MenuPage({Key? key, required this.tecnico}) : super(key: key);

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido, ${tecnico.nombreTecnico}'),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(tecnico: tecnico), // Pasar el objeto Tecnico
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
                    builder: (context) => HistorialVentasPage(idTecnico: tecnico.idTecnico),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Historial de Canjes'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(tecnico: tecnico),
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
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: [
            _buildMenuButton(context, 'Ver Perfil', Icons.person, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(tecnico: tecnico),
                ),
              );
            }),
            _buildMenuButton(context, 'Historial de Ventas Intermediadas', Icons.history, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HistorialVentasPage(idTecnico: tecnico.idTecnico),
                ),
              );
            }),
            _buildMenuButton(context, 'Historial de Canjes', Icons.swap_horiz, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(tecnico: tecnico),
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
        backgroundColor: Color(0xFF3B82F6),
        padding: EdgeInsets.symmetric(vertical: 20),
        textStyle: TextStyle(fontSize: 20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.white),
          const SizedBox(height: 10),
          Text(title, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

