import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../data/models/login_request.dart';
import 'dart:convert'; 

class TestLoginPage extends StatelessWidget {
  final ApiService _apiService = ApiService.create();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Test Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: testLogin,
          child: Text('Probar Login'),
        ),
      ),
    );
  }

  void testLogin() async {
    try {
      final csrfResponse = await _apiService.getCsrfToken();
      final csrfToken = csrfResponse.csrf_token;

      final loginRequest = LoginRequest(
        celularTecnico: "999888777",
        password: "contraseña123",
      );

      // Imprimir detalles de la solicitud
      print('URL: http://192.168.0.15/FidelizacionTecnicos/public/api/loginmovil/login-tecnico');
      print('Encabezados:');
      print('X-CSRF-TOKEN: $csrfToken');
      print('Content-Type: application/json');
      print('Cuerpo de la solicitud: ${jsonEncode(loginRequest.toJson())}');

      final response = await _apiService.loginTecnico(
        loginRequest
      );

    
    } catch (e) {
      print('Error: $e');
    }
  }
}
