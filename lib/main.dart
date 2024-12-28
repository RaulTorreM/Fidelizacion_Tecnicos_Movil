import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/screens/home_page.dart';
import 'logic/recompensa_bloc.dart';
import 'logic/login_bloc.dart';
import 'logic/profile_bloc.dart';
import 'logic/venta_intermediada_bloc.dart';  // Corregido el nombre del archivo
import 'data/repositories/perfil_repository.dart';
import 'services/api_service.dart';  // Asegúrate de que ApiService se importa correctamente
import 'dart:io';

void main() {
  // HttpOverrides.global = MyHttpOverrides(); //Quitarlo al momento de llevarlo a producción
  runApp(MyApp());
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
        // Página de Recompensas
        ChangeNotifierProvider(create: (context) => RecompensaBloc(DioInstance().getApiService())),

        // Proveedor para PerfilRepository
        Provider<PerfilRepository>(create: (context) => PerfilRepository(DioInstance().getApiService())),

        // Proveedor para LoginBloc
        ChangeNotifierProvider<LoginBloc>(create: (context) => LoginBloc(DioInstance().getApiService())),

        // Proveedor para VentasIntermediadasBloc
        ChangeNotifierProvider<VentasIntermediadasBloc>(
          create: (context) => VentasIntermediadasBloc(DioInstance().getApiService()),
        ),

        // Proveedor para ProfileBloc
        ChangeNotifierProvider<ProfileBloc>(create: (context) => ProfileBloc(Provider.of<PerfilRepository>(context, listen: false))),
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
