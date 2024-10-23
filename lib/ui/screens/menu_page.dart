import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'historialVentas_page.dart';
import '../../data/models/tecnico.dart';
import '../screens/recompensas_page.dart'; 
import '../../logic/login_bloc.dart';
import 'package:provider/provider.dart';
import 'home_page.dart'; 

class MenuPage extends StatefulWidget {
  final Tecnico tecnico;
  final bool isFirstLogin;

  const MenuPage({Key? key, required this.tecnico, this.isFirstLogin = false}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  void initState() {
    super.initState();

    print(widget.isFirstLogin);

    // Mostrar el diálogo de cambio de contraseña si es el primer login
    if (widget.isFirstLogin) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showChangePasswordDialog();
      });
    }
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text('Cambio de Contraseña'),
          content: const Text(
            'Por seguridad, debe cambiar su contraseña ya que es su primer inicio de sesión.',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: const Text(
                'Aceptar',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }

  // Lógica para cerrar sesión y redirigir al HomePage
  void _logout(BuildContext context) {
    // Obtener el LoginBloc
    final loginBloc = Provider.of<LoginBloc>(context, listen: false);
    
    // Llamar al método logout
    loginBloc.logout();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()), // O LoginPage
      (route) => false, // Esto elimina todas las rutas anteriores
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido, ${widget.tecnico.nombreTecnico}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _logout(context);  // Llama a la función de logout al presionar el botón
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF021526)),
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
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(idTecnico: widget.tecnico.idTecnico,),
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
                  builder: (context) => ProfilePage(idTecnico: widget.tecnico.idTecnico,),
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
