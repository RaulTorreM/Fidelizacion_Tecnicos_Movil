

import 'package:flutter/material.dart';
import '../data/repositories/tecnico_repository.dart';
import '../services/api_service.dart';
import '../data/models/tecnico.dart';

import '../data/models/login_request.dart';

class LoginBloc with ChangeNotifier {
  final TecnicoRepository _tecnicoRepository;
  bool isFirstLogin = false; 

  LoginBloc(ApiService apiService) : _tecnicoRepository = TecnicoRepository(apiService);

  Tecnico? _tecnico;
  String? _error;
  bool _isLoading = false;

  Tecnico? get tecnico => _tecnico;
  String? get error => _error;
  bool get isLoading => _isLoading;

  // Método de login usando el repositorio
  Future<void> login(String celular, String password, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Crear el objeto LoginRequest con los datos de login
      final loginRequest = LoginRequest(
        // celularTecnico: "964866527",
        // password: "asd",
        celularTecnico: celular, 
        password: password,
      );

      // Llamar al método loginTecnico del repositorio
      final loginResponse = await _tecnicoRepository.loginTecnico(loginRequest);

      if (loginResponse.status == 'success') {
        
        isFirstLogin = loginResponse.isFirstLogin;
        print(isFirstLogin);
        await obtenerDetallesTecnico(loginResponse.idTecnico);
      } else {
        _error = loginResponse.message;
      }
    } catch (e) {
      _error = 'Error desconocido: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Método para obtener los detalles del técnico desde el repositorio
  Future<void> obtenerDetallesTecnico(String idTecnico) async {
    try {
      final tecnico = await _tecnicoRepository.obtenerTecnicoPorId(idTecnico);
      _tecnico = tecnico;
    } catch (e) {
      _error = 'Error al obtener detalles del técnico: $e';
    } finally {
      notifyListeners();
    }
  }

  void clear() {
    _tecnico = null;
    _error = null;
    notifyListeners();
  }
  
   void showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Cambio de Contraseña'),
          content: Text('Por seguridad, debe cambiar su contraseña ya que es su primer inicio de sesión.'),
          actions: [
            TextButton(
              onPressed: () {
                // Aquí puedes manejar la lógica de redireccionamiento o acción cuando se cierra el diálogo
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  void logout() {
    // Limpiar los datos del técnico
    _tecnico = null;
    isFirstLogin = false;
    _error = null;

    // Si tienes datos persistentes, como SharedPreferences o token de autenticación, también deberías limpiarlos aquí.
    // Ejemplo:
    // await SharedPreferences.getInstance().then((prefs) {
    //   prefs.clear(); // Esto borraría todos los datos persistidos.
    // });
    notifyListeners();
  }
}