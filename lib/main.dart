import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/screens/home_page.dart';
import 'logic/login_bloc.dart';
import 'logic/profile_bloc.dart';
import 'data/repositories/perfil_repository.dart';
import 'services/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Proveedor para ApiService
        Provider<ApiService>(create: (_) => ApiService.create()),

        // Proveedor para PerfilRepository
        Provider<PerfilRepository>(
          create: (context) => PerfilRepository(Provider.of<ApiService>(context, listen: false)),
        ),

        // Proveedor para LoginBloc
        ChangeNotifierProvider<LoginBloc>(
          create: (context) => LoginBloc(Provider.of<ApiService>(context, listen: false)),
        ),

        // Proveedor para PerfilBloc
        ChangeNotifierProvider<ProfileBloc>(
        create: (context) => ProfileBloc(Provider.of<PerfilRepository>(context, listen: false)),
      )
      ,
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
