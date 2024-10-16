import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/screens/login_page.dart';
import 'ui/screens/menu_page.dart';
import 'ui/screens/cambioContraseña_page.dart';
import 'logic/login_bloc.dart';
import 'logic/profile_bloc.dart';
import 'data/repositories/perfil_repository.dart';
// Asegúrate de importar tu RecompensaBloc
import 'services/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        
        Provider<ApiService>(create: (_) => ApiService.create()), 
        ChangeNotifierProvider(create: (context) => LoginBloc(Provider.of<ApiService>(context, listen: false))),
        
         Provider<PerfilRepository>(
        create: (context) => PerfilRepository(Provider.of<ApiService>(context, listen: false)),),

        ChangeNotifierProvider<PerfilBloc>(
          create: (context) {
            final apiService = Provider.of<ApiService>(context, listen: false);
            final perfilRepository = Provider.of<PerfilRepository>(context, listen: false);
            return PerfilBloc(apiService, perfilRepository); // Pasa ambos parámetros
          },
        ),
      ],
      child: MaterialApp(
        title: 'Técnicos App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
        },
      ),
    );
  }
}
