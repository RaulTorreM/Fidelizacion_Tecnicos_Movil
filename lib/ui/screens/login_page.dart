import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../logic/login_bloc.dart';
import 'package:dio/dio.dart';
import '../../util/background_painter.dart';
import 'menu_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController celularController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _testApiConnection(BuildContext context) async {
    final dio = Dio(); // Crea una instancia de Dio
    try {
      final response = await dio.get("http://192.168.137.54/FidelizacionTecnicos/public/api/loginmovil/login-DataTecnicos");

      if (response.statusCode == 200) {
        if (response.data is List) {
          final List<dynamic> tecnicosData = response.data;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Conexión exitosa: ${tecnicosData.length} técnicos encontrados.')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: Se esperaba una lista de técnicos.')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: Código de respuesta ${response.statusCode}.')),
        );
      }
    } catch (e) {
      print('Error al probar la conexión: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error de conexión: $e')),
      );
    }
  }

  Future<void> _login(BuildContext context) async {
    final loginBloc = Provider.of<LoginBloc>(context, listen: false);

    if (_formKey.currentState!.validate()) {
      // Ejecuta el método de login
      await loginBloc.login(celularController.text, passwordController.text, context);

      // Verifica si el técnico fue autenticado correctamente
      if (loginBloc.tecnico != null) {
        // Navega a MenuPage solo si el login es exitoso
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MenuPage(
              tecnico: loginBloc.tecnico!,
              isFirstLogin: loginBloc.isFirstLogin,
            ),
          ),
        );
      } else if (loginBloc.error != null) {
        // Muestra el mensaje de error si el login falló
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(loginBloc.error!)),
        );
      } else {
        // Muestra un mensaje de error genérico si algo falla inesperadamente
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: const Text('Error desconocido.')),
        );
      }
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
        backgroundColor: const Color(0xFF021526),
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
                      color: Color(0xFFE2E2B6),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Formulario de inicio de sesión
                  TextFormField(
                    controller: celularController,
                    decoration: InputDecoration(
                      labelText: 'Teléfono',
                      filled: true,
                      fillColor: const Color(0xFF03346E),
                      labelStyle: const TextStyle(color: Color(0xFFE2E2B6)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFFE2E2B6)),
                      ),
                    ),
                    style: const TextStyle(color: Color(0xFFE2E2B6)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su Teléfono';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      filled: true,
                      fillColor: const Color(0xFF03346E),
                      labelStyle: const TextStyle(color: Color(0xFFE2E2B6)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFFE2E2B6)),
                      ),
                    ),
                    obscureText: true,
                    style: const TextStyle(color: Color(0xFFE2E2B6)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su contraseña';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => _login(context),
                    child: const Text('Ingresar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 4, 26, 43),
                      minimumSize: const Size(double.infinity, 50),
                      foregroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _testApiConnection(context),
                    child: const Text('Probar Conexión API', style: TextStyle(color: Color(0xFF021526))),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE2E2B6),
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
