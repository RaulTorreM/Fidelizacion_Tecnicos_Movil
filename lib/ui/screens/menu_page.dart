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

  const MenuPage({Key? key, required this.tecnico, this.isFirstLogin = false})
      : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String backgroundImage = 'assets/others/fondo_default.jpg';

  @override
  void initState() {
    super.initState();

    if (widget.isFirstLogin) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showChangePasswordDialog();
      });
    }

    _checkBirthday();
  }

  void _checkBirthday() {
    DateTime currentDate = DateTime.now();
    DateTime birthDate = DateTime.parse(widget.tecnico.fechaNacimientoTecnico!);

    if (currentDate.month == birthDate.month &&
        currentDate.day == birthDate.day) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
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
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.pinkAccent,
        duration: const Duration(seconds: 10),
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
                Navigator.of(context).pop();
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
    prefs.remove('api_key');
  }

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
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Bienvenido, ${widget.tecnico.nombreTecnico}',
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4), BlendMode.darken),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            children: [
              _buildMenuCard('Perfil', Icons.person, () => _navigateTo(ProfilePage(idTecnico: widget.tecnico.idTecnico))),
              _buildMenuCard('Historial de Ventas', Icons.history, () => _navigateTo(HistorialVentasPage(idTecnico: widget.tecnico.idTecnico))),
              _buildMenuCard('Recompensas', Icons.card_giftcard, () => _navigateTo(const RecompensasPage())),
              _buildMenuCard('Solicitar Canje', Icons.badge, () => _navigateTo(SolicitudCanjePage(idTecnico: widget.tecnico.idTecnico))),
              _buildMenuCard('Ver Solicitudes', Icons.queue_play_next, () => _navigateTo(VerSolicitudesCanjePage(idTecnico: widget.tecnico.idTecnico))),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateTo(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  Widget _buildMenuCard(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.2),
        color: const Color(0xFF313263),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
