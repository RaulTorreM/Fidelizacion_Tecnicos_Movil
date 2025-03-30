import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../services/api_service.dart';
import 'profile_page.dart';
import 'historialVentas_page.dart';
import '../../data/models/tecnico.dart';
import '../../data/models/notification_venta.dart';
import '../../data/repositories/notification_repository.dart';
import '../../logic/notification_bloc.dart';
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
  late NotificationBloc _notificationBloc;

  @override
  void initState() {
    super.initState();

    
    // Obtener el repository del contexto
  final notificationRepository = Provider.of<NotificationRepository>(
    context, 
    listen: false
  );
  
  // Inicializar el bloc
  _notificationBloc = NotificationBloc(notificationRepository);

    if (widget.isFirstLogin) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showChangePasswordDialog();
      });
    }

    _checkBirthday();
    
  }
  @override
  void dispose() {
    ScaffoldMessenger.of(context).clearSnackBars();
    super.dispose();
  }



  Future<void> _loadNotifications() async {
  try {
    await _notificationBloc.loadNotifications(widget.tecnico.idTecnico);
    
    if (!mounted) return; 
    
    final notifications = _notificationBloc.notifications;
    
    if (notifications.isEmpty) return;

    if (notifications.length == 1) {
      _showSingleNotification(notifications.first);
    } else {
      _showMultipleNotifications(notifications);
    }
  } catch (e, stackTrace) {
    print('Error en MenuPage: $e');
    print('Stack trace: $stackTrace');
  }
}

void _showSingleNotification(TecnicoNotification notification) {
  final theme = Theme.of(context);
  final isBirthday = notification.description.contains('Cumpleaños');

  final snackBar = SnackBar(
    content: Row(
      children: [
        Icon(
          isBirthday ? Icons.cake_rounded : Icons.notifications_active_rounded,
          color: Colors.white,
          size: 28,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isBirthday ? '¡Celebración!' : 'Nueva notificación',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                notification.description,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                DateFormat('HH:mm', 'es_ES').format(notification.createdAt),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.white.withOpacity(0.75),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    backgroundColor: isBirthday 
        ? Colors.pinkAccent
        : theme.colorScheme.primary,
    duration: const Duration(seconds: 10),
    dismissDirection: DismissDirection.down,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    margin: const EdgeInsets.only(
      bottom: 20,
      left: 16,
      right: 16,
      top: 8,
    ),
    elevation: 4,
    action: SnackBarAction(
      label: 'Ver',
      textColor: Colors.white,
      backgroundColor: Colors.black.withOpacity(0.1),
      onPressed: () => _openNotificationsDialog([notification]),
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}

void _showMultipleNotifications(List<TecnicoNotification> notifications) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text('Tienes ${notifications.length} notificaciones'),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 10), 
      dismissDirection: DismissDirection.down, 
      behavior: SnackBarBehavior.floating, 
      action: SnackBarAction(
        label: 'Ver',
        textColor: Colors.white,
        onPressed: () {
          // scaffold.hideCurrentSnackBar();
          _openNotificationsDialog(notifications);
        },
      ),
    ),
  );
}

  void _openNotificationsDialog(List<TecnicoNotification> notifications) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.notifications_active_outlined,
                    color: colorScheme.primary, size: 28),
                const SizedBox(width: 12),
                Text(
                  'Notificaciones',
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Tienes ${notifications.length} notificaciones nuevas',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 20),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.5,
              ),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: notifications.length,
                separatorBuilder: (context, index) => const Divider(height: 16),
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  final isSystemNotification = 
                      notification.idVentaIntermediada == null;

                  return Container(
                    decoration: BoxDecoration(
                      color: isSystemNotification
                          ? colorScheme.primary.withOpacity(0.1)
                          : colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isSystemNotification
                                ? colorScheme.primary
                                : colorScheme.secondary,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isSystemNotification
                                ? Icons.verified_user_outlined
                                : Icons.local_offer_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notification.description,
                                style: textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                DateFormat('EEE, d MMM yyyy · HH:mm', 'es_ES').format(notification.createdAt),
                                style: textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurface.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                'Cerrar',
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


  void _checkBirthday() {
  final currentDate = DateTime.now().subtract(Duration(
    hours: DateTime.now().timeZoneOffset.inHours + 5,
  ));
  DateTime birthDate = DateTime.parse(widget.tecnico.fechaNacimientoTecnico!);

  if (currentDate.month == birthDate.month &&
      currentDate.day == birthDate.day) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        backgroundImage = 'assets/others/fondo_cumpleaños.jpg';
      });
      _showBirthdayMessage();
      Future.delayed(const Duration(milliseconds: 300), _loadNotifications);
    });
  } else {
    _loadNotifications();
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
    ScaffoldMessenger.of(context).clearSnackBars(); 

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
