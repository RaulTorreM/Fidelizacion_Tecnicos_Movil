import 'package:flutter/material.dart';
import 'profile_page.dart'; 
import 'historialVentas_page.dart';
import '../../data/models/tecnico.dart';
import 'package:provider/provider.dart';
import '../../logic/login_bloc.dart'; // Asegúrate de importar tu LoginBloc
import '../screens/recompensas_page.dart';

class MenuPage extends StatefulWidget {
  final Tecnico tecnico;

  const MenuPage({Key? key, required this.tecnico}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido, ${widget.tecnico.nombreTecnico}'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF021526)),
              child: const Text(
                'Navegación',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Ver Perfil'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(tecnico: widget.tecnico),
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
                    builder: (context) => HistorialVentasPage(idTecnico: widget.tecnico.idTecnico),
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
          crossAxisCount: 2, // Número de columnas
          crossAxisSpacing: 16.0, // Espacio horizontal entre tarjetas
          mainAxisSpacing: 16.0, // Espacio vertical entre tarjetas
          children: [
            _buildMenuCard('Perfil', Icons.person, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(tecnico: widget.tecnico),
                ),
              );
            }),
            _buildMenuCard('Historial de Ventas', Icons.history, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HistorialVentasPage(idTecnico: widget.tecnico.idTecnico),
                ),
              );
            }),
            _buildMenuCard('Recompensas', Icons.card_giftcard, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RecompensasPage(),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: const Color.fromARGB(255, 49, 50, 99),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: const Color.fromARGB(255, 239, 239, 240),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
