import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/screens/login_page.dart';
import 'logic/login_bloc.dart';
import 'logic/recompensa_bloc.dart'; // Asegúrate de importar tu RecompensaBloc
import 'services/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiService>(create: (_) => ApiService.create()), // Inicializa ApiService
        ChangeNotifierProvider(create: (context) => LoginBloc(Provider.of<ApiService>(context, listen: false))),
        
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
