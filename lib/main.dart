import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/screens/home_page.dart';
import 'logic/recompensa_bloc.dart';
import 'logic/login_bloc.dart';
import 'logic/profile_bloc.dart';
import 'logic/notification_bloc.dart';
import 'logic/venta_intermediada_bloc.dart';  // Corregido el nombre del archivo
import 'data/repositories/perfil_repository.dart';
import 'data/repositories/notification_repository.dart';
import 'services/api_service.dart';  // Asegúrate de que ApiService se importa correctamente
import 'dart:io';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  // HttpOverrides.global = MyHttpOverrides(); //Quitarlo al momento de llevarlo a producción
  initializeDateFormatting('es_ES', null).then((_) {
    runApp(MyApp());
  });
}

//Función solamente para Desarrollo (SSL en emuladores), Quitarlo al momento de llevarlo a producción junto con la linea marcada en Main
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Proveedor principal para ApiService
        Provider<ApiService>(
          create: (context) => DioInstance().getApiService(),
        ),

        ChangeNotifierProvider<NotificationBloc>(
        create: (context) => NotificationBloc(
          NotificationRepository(
            Provider.of<ApiService>(context, listen: false)
          )
        ),
      ),

        // Proveedor para NotificationRepository
        Provider<NotificationRepository>(
          create: (context) => NotificationRepository(
            Provider.of<ApiService>(context, listen: false)
          ),
        ),

        // Proveedores actualizados usando la instancia existente de ApiService
        ChangeNotifierProvider(
          create: (context) => RecompensaBloc(
            Provider.of<ApiService>(context, listen: false)
          ),
        ),

        Provider<PerfilRepository>(
          create: (context) => PerfilRepository(
            Provider.of<ApiService>(context, listen: false)
          ),
        ),

        ChangeNotifierProvider<LoginBloc>(
          create: (context) => LoginBloc(
            Provider.of<ApiService>(context, listen: false)
          ),
        ),

        ChangeNotifierProvider<VentasIntermediadasBloc>(
          create: (context) => VentasIntermediadasBloc(
            Provider.of<ApiService>(context, listen: false)
          ),
        ),

        ChangeNotifierProvider<ProfileBloc>(
          create: (context) => ProfileBloc(
            Provider.of<PerfilRepository>(context, listen: false)
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Club de Técnicos',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
        },
      ),
    );
  }
}
