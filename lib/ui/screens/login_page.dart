import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../logic/login_bloc.dart';
import 'package:dio/dio.dart';
import '../../util/background_painter.dart';
import 'menu_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController celularController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _isObscured = ValueNotifier(true); // Controlador para mostrar/ocultar la contraseña

  Future<void> _testApiConnection(BuildContext context) async {
    final dio = Dio();
    try {
      final response = await dio.get("https://clubtecnicosdimacof.site/api/loginmovil/login-DataTecnicos");

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
      await loginBloc.login(celularController.text, passwordController.text, context);

      if (loginBloc.tecnico != null) {
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Las Credenciales Ingresadas son Invalidas, intentelo nuevamente.")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: const Text('Error desconocido.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Ajusta automáticamente el diseño al abrir el teclado
      appBar: AppBar(
        title: const Text('Ingrese sus Credenciales', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
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
          SingleChildScrollView( // Envuelve el contenido para evitar desbordes
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  const SizedBox(height: 50),
                  Image.asset(
                    "assets/icons/logo_png.png",
                    width: 200,
                    height: 200,
                    errorBuilder: (context, error, stackTrace) {
                      return Text('Error al cargar la imagen: $error', style: const TextStyle(color: Colors.white));
                    },
                  ),
                  const SizedBox(height: 15),
                  // Título
                  const Text(
                    'Iniciar Sesión',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      color: Color(0xFFE2E2B6),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 35),
                  // Teléfono
                  TextFormField(
                    controller: celularController,
                    keyboardType: TextInputType.phone, // Muestra teclado numérico
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(9), // Limita a 9 caracteres
                    ],
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
                  // Contraseña con botón de mostrar/ocultar
                  ValueListenableBuilder<bool>(
                    valueListenable: _isObscured,
                    builder: (context, isObscured, child) {
                      return TextFormField(
                        controller: passwordController,
                        obscureText: isObscured,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          filled: true,
                          fillColor: const Color(0xFF03346E),
                          labelStyle: const TextStyle(color: Color(0xFFE2E2B6)),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isObscured ? Icons.visibility_off : Icons.visibility,
                              color: Color(0xFFE2E2B6),
                            ),
                            onPressed: () {
                              _isObscured.value = !isObscured;
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xFFE2E2B6)),
                          ),
                        ),
                        style: const TextStyle(color: Color(0xFFE2E2B6)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese su contraseña';
                          }
                          return null;
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  // Botón Ingresar
                  ElevatedButton(
                    onPressed: () => _login(context),
                    child: const Text('Ingresar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 4, 26, 43),
                      minimumSize: const Size(double.infinity, 50),
                      foregroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Olvidó su contraseña
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          title: Row(
                            children: [
                              Icon(Icons.info_outline, color: Colors.blue, size: 28),
                              const SizedBox(width: 10),
                              const Text(
                                'Recuperar Contraseña',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          content: const Text(
                            'Para restablecer su contraseña, por favor acérquese a nuestras oficinas más cercanas. Nuestro equipo estará encantado de ayudarle.',
                            style: TextStyle(fontSize: 16),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text(
                                'Cerrar',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text(
                      '¿Olvidó su contraseña?',
                      style: TextStyle(color: Colors.white70),
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
