import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/screens/home_page.dart';
import 'logic/recompensa_bloc.dart';
import 'logic/login_bloc.dart';
import 'logic/profile_bloc.dart';
import 'logic/venta_intermediada_bloc.dart';  // Corregido el nombre del archivo
import 'data/repositories/perfil_repository.dart';
import 'services/api_service.dart';
import 'dart:io';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Proveedor para ApiService
        Provider<ApiService>(create: (_) => ApiService.create()),

        // Proveedor para PerfilRepository
        Provider<PerfilRepository>(create: (context) => PerfilRepository(Provider.of<ApiService>(context, listen: false))),

        // Proveedor para LoginBloc
        ChangeNotifierProvider<LoginBloc>(create: (context) => LoginBloc(Provider.of<ApiService>(context, listen: false))),

        // Proveedor para VentasIntermediadasBloc (Cambio de ChangeNotifierProvider a Provider)
        ChangeNotifierProvider<VentasIntermediadasBloc>(
          create: (context) => VentasIntermediadasBloc(Provider.of<ApiService>(context, listen: false)),
        ),

        // Proveedor para RecompensaBloc
        ChangeNotifierProvider<RecompensaBloc>(create: (context) => RecompensaBloc(Provider.of<ApiService>(context, listen: false))),

        // Proveedor para ProfileBloc
        ChangeNotifierProvider<ProfileBloc>(create: (context) => ProfileBloc(Provider.of<PerfilRepository>(context, listen: false))),
      ],
      child: MaterialApp(
        title: 'Técnicos App',
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
