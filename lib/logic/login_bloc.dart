
import 'dart:convert';

import 'package:flutter/material.dart';
import '../data/models/login_request.dart';
import '../data/models/login_response.dart';
import '../data/repositories/tecnico_repository.dart';
import '../services/api_service.dart';
import '../data/models/tecnico.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart'as http;

class LoginBloc with ChangeNotifier {
    final TecnicoRepository _tecnicoRepository;

    LoginBloc(ApiService apiService) : _tecnicoRepository = TecnicoRepository(apiService);

    Tecnico? _tecnico;
    String? _error;
    bool _isLoading = false;

    Tecnico? get tecnico => _tecnico;
    String? get error => _error;
    bool get isLoading => _isLoading;

    
    // Método de login
    Future<void> login(String celular, String password) async {
      _isLoading = true; // Indica que está en proceso de carga
      notifyListeners(); // Notifica a los oyentes que el estado ha cambiado

      try {
        final response = await Dio().post('http://192.168.0.15/FidelizacionTecnicos/public/api/loginmovil/login-tecnico', data: {
          'celularTecnico': '964866527',
          'password': 'contraseña123',
          
          
          // 'celularTecnico': celular,
          // 'password': password,

        });

        print('Login Response: ${response.data}'); // Imprimir respuesta para depuración

        if (response.data['status'] == 'success') {
          String idTecnico = response.data['idTecnico'];
          await obtenerDetallesTecnico(idTecnico);
        } else {
          _error = response.data['message'];
        }
      } catch (e) {
        _error = 'Error desconocido: ${e.toString()}';
      } finally {
        _isLoading = false; // Cambia el estado de carga
        notifyListeners(); // Notifica a los oyentes nuevamente
      }
    }

     Future<void> obtenerDetallesTecnico(String idTecnico) async {
      try {
        final response = await Dio().get('http://192.168.0.15/FidelizacionTecnicos/public/api/getTecnico/$idTecnico');
        print('Detalles del Técnico: ${response.data}'); // Imprimir respuesta para depuración

        if (response.data['tecnico'] != null) {
          _tecnico = Tecnico.fromJson(response.data['tecnico']);
          
        } else {
          _error = 'Error al obtener detalles del técnico: Datos no encontrados';
        }
      } catch (e) {
        _error = 'Error al obtener detalles del técnico: ${e.toString()}';
      }
      notifyListeners(); // Notifica a los oyentes después de cambiar el estado
    }


    void clear() {
      _tecnico = null;
      _error = null;
      notifyListeners();
    }



  Future<void> loginSimple() async {
    try {
      final response = await http.post(
        Uri.parse("http://192.168.0.15/FidelizacionTecnicos/public/api/loginmovil/login-tecnico"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"celularTecnico": "964866527", "password": "contraseña123"}),
      );

      final jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
    } catch (e) {
      print("Error: $e");
    }
  }


}
