import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'historialVentas_page.dart';
import '../../data/models/tecnico.dart';
import '../screens/recompensas_page.dart'; 
import '../screens/solicitudCanje_page.dart'; 
import '../screens/verSolicitudesCanje_page.dart'; 
import '../../logic/login_bloc.dart';
import 'package:provider/provider.dart';
import 'home_page.dart'; 
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MenuPage extends StatefulWidget {
  final Tecnico tecnico;
  final bool isFirstLogin;

  const MenuPage({Key? key, required this.tecnico, this.isFirstLogin = false}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String backgroundImage = 'assets/others/fondo_default.jpg';  // Fondo por defecto

  @override
  void initState() {
    super.initState();

    // Mostrar el diálogo de cambio de contraseña si es el primer login
    if (widget.isFirstLogin) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showChangePasswordDialog();
      });
    }

    // Comprobar si es el cumpleaños del técnico
    _checkBirthday();


  }



  void _checkBirthday() {
    DateTime currentDate = DateTime.now();
    DateTime birthDate = DateTime.parse(widget.tecnico.fechaNacimientoTecnico!);

    if (currentDate.month == birthDate.month && currentDate.day == birthDate.day) {
      // Usar addPostFrameCallback para esperar hasta que el widget esté listo
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Cambiar el fondo y mostrar el mensaje de cumpleaños
        setState(() {
          backgroundImage = 'assets/others/fondo_cumpleaños.jpg';
        });
        _showBirthdayMessage();
      });
    }
  }

  void _showBirthdayMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '¡Feliz Cumpleaños!, ¡Te deseamos un excelente día!',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.pinkAccent, // Color del banner
        duration: Duration(seconds: 10), // Duración del banner
      ),
    );
  }

    void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            children: [
              Icon(Icons.lock_outline, color: Colors.blue, size: 28),
              const SizedBox(width: 10),
              const Text(
                'Actualización de Contraseña',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: const Text(
            'Por motivos de seguridad, le solicitamos actualizar su contraseña. Este proceso garantiza la protección de su cuenta y el acceso seguro a nuestros servicios.',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: const Text(
                'Entendido',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }


  Future<void> removeApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('api_key'); // Eliminar la API Key
  }

  // Lógica para cerrar sesión y redirigir al HomePage
  void _logout(BuildContext context) async {
    final loginBloc = Provider.of<LoginBloc>(context, listen: false);
    loginBloc.logout();
    await removeApiKey();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      appBar: AppBar(
        automaticallyImplyLeading: false, 
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage), // Usar el fondo dinámico
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            children: [
              _buildMenuCard('Perfil', Icons.person, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(idTecnico: widget.tecnico.idTecnico),
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
              _buildMenuCard('Solicitar Canje', Icons.badge, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SolicitudCanjePage(idTecnico: widget.tecnico.idTecnico),
                  ),
                );
              }),
              _buildMenuCard('Ver Solicitudes', Icons.queue_play_next, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VerSolicitudesCanjePage(idTecnico: widget.tecnico.idTecnico),
                  ),
                );
              }),
            ],
          ),
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
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
