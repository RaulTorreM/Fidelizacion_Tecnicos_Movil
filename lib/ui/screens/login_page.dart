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
      final response = await dio.get("http://192.168.0.15/ProbandoDIMACOF/public/api/loginmovil/login-DataTecnicos");

      if (response.statusCode == 200) {
        // Asegúrate de que la respuesta sea un List
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
      await loginBloc.login(celularController.text, passwordController.text,context);

      if (loginBloc.tecnico != null) {
      // Navega a MenuPage pasando la bandera isFirstLogin
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MenuPage(
            tecnico: loginBloc.tecnico!,
            isFirstLogin: loginBloc.isFirstLogin,  // Pasa la variable que indica si es el primer login
          ),
        ),
      );
    } else if (loginBloc.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loginBloc.error!)),
      );
    } else if (loginBloc.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(loginBloc.error!)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error desconocido.')),
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
                    controller: celularController,
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
                    controller: passwordController,
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
                    onPressed: () => _login(context),
                    child: Text('Ingresar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 4, 26, 43), // Color del botón
                      minimumSize: const Size(double.infinity, 50),
                      foregroundColor: Colors.white, // Color del texto
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _testApiConnection(context), // Acción para probar la conexión API
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
