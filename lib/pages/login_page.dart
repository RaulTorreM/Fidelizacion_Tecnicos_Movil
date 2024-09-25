import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../api_connection/api_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _dniController = TextEditingController();
  final _passwordController = TextEditingController();
  final ApiService _apiService = ApiService.create();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await _apiService.login(
          LoginRequest(
            idTecnico: _dniController.text,
            password: _passwordController.text,
          ),
        );
        
        if (response.status == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Bienvenido, ${response.idTecnico}')),
          );
          // Aquí puedes navegar a la siguiente pantalla después del login exitoso
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.message)),
          );
        }
      } catch (e) {
        print('Error al conectar con la API: $e');
        if (e is DioException) {
          print('DioError tipo: ${e.type}');
          print('DioError mensaje: ${e.message}');
          print('DioError respuesta: ${e.response}');
          print('DioError error: ${e.error}');
          print('DioError requestOptions: ${e.requestOptions.uri}');
        }
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error de conexión: $e')),
        );
      }
    }
  }

  Future<void> _testApiConnection() async {
    try {
      print('Iniciando prueba de conexión API...');
      
      // Llama al método getAllTecnicos
      final List<Tecnico> tecnicos = await _apiService.getAllTecnicos();
      
      // Imprime la lista de técnicos
      print('Lista de Técnicos:');
      for (var tecnico in tecnicos) {
        print('ID Técnico: ${tecnico.idTecnico}');
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Conexión exitosa. Revisa la consola para más detalles.')),
      );
    } catch (e) {
      print('Error al conectar con la API: $e');
      if (e is DioException) {
        print('DioError tipo: ${e.type}');
        print('DioError mensaje: ${e.message}');
        print('DioError respuesta: ${e.response}');
        print('DioError error: ${e.error}');
        print('DioError requestOptions: ${e.requestOptions.uri}');
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error de conexión. Revisa la consola para más detalles.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _dniController,
                decoration: InputDecoration(labelText: 'DNI'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su DNI';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su contraseña';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _login,
                child: Text('Ingresar'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _testApiConnection,
                child: Text('Probar Conexión API'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
