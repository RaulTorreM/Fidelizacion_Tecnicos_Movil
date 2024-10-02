import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../api_connection/api_service.dart';
import 'temporal_page.dart';
import '../util/background_painter.dart'; // Importa el CustomPainter
import 'menu_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _numTelefonoController = TextEditingController();
  final _passwordController = TextEditingController();
  final ApiService _apiService = ApiService.create();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Crear el objeto de solicitud de inicio de sesión
        final loginRequest = LoginRequest(
          celularTecnico: _numTelefonoController.text, 
          password: _passwordController.text,
        );

        // Realizar la solicitud de inicio de sesión
        final response = await _apiService.loginTecnico(loginRequest);

        if (response.status == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Bienvenido, ${response.tecnico!.nombreTecnico}')),
          );

          // Navegar a la página siguiente
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MenuPage(tecnico: response.tecnico!)),
          );
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
      // Realizar una solicitud de prueba a la API
      final response = await _apiService.getAllTecnicos(); // Llamar al método getAllTecnicos

      if (response.isNotEmpty) { // Verificar si la lista no está vacía
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Conexión exitosa: ${response.length} técnicos encontrados.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: No se encontraron técnicos.')),
        );
      }
    } catch (e) {
      print('Error al probar la conexión: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error de conexión: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingrese sus Credenciales', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Regresar a HomePage
          },
        ),
        backgroundColor: Color(0xFF021526), // Color de la AppBar
      ),
      body: Stack(
        children: [
          // Fondo con triángulos
          CustomPaint(
            size: Size.infinite,
            painter: BackgroundPainter(),
          ),
          // Contenido
          Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Image.asset(
                    "assets/icons/logo_png.png",
                    width: 200,
                    height: 200,
                    errorBuilder: (context, error, stackTrace) {
                      return Text('Error al cargar la imagen: $error', style: const TextStyle(color: Colors.white));
                    },
                  ),

                  const SizedBox(height: 20),

                  // Título
                  const Text(
                    'Iniciar Sesión',
                    style: TextStyle(
                      fontSize: 24,
                      color: Color(0xFFE2E2B6), // Color del texto
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Formulario de inicio de sesión
                  TextFormField(
                    controller: _numTelefonoController,
                    decoration: InputDecoration(
                      labelText: 'Teléfono',
                      filled: true,
                      fillColor: Color(0xFF03346E), // Color de fondo del campo
                      labelStyle: TextStyle(color: Color(0xFFE2E2B6)), // Color de la etiqueta
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Color(0xFFE2E2B6)), // Borde claro
                      ),
                    ),
                    style: TextStyle(color: Color(0xFFE2E2B6)), // Color del texto
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su Teléfono';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      filled: true,
                      fillColor: Color(0xFF03346E), // Color de fondo del campo
                      labelStyle: TextStyle(color: Color(0xFFE2E2B6)), // Color de la etiqueta
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Color(0xFFE2E2B6)), // Borde claro
                      ),
                    ),
                    obscureText: true,
                    style: TextStyle(color: Color(0xFFE2E2B6)), // Color del texto
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su contraseña';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _login,
                    child: Text('Ingresar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 4, 26, 43), // Color del botón
                      minimumSize: const Size(double.infinity, 50),
                      foregroundColor: Colors.white, // Color del texto
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _testApiConnection, // Acción para probar la conexión API
                    child: Text('Probar Conexión API', style: TextStyle(color: Color(0xFF021526))), // Color del texto
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFE2E2B6), // Color del botón
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
