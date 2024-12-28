import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../data/repositories/tecnico_repository.dart';
import '../services/api_service.dart';
import '../data/models/tecnico.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      final loginRequest = LoginRequest(
        celularTecnico: celular,
        password: password,
      );

      final loginResponse = await _tecnicoRepository.loginTecnico(loginRequest);

      if (loginResponse.status == 'success') {
        isFirstLogin = loginResponse.isFirstLogin;

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('apikey', loginResponse.apiKey);
        await obtenerDetallesTecnico(loginResponse.idTecnico);

        if (isFirstLogin) {
          showChangePasswordDialog(context); // Mostrar un diálogo para cambiar la contraseña
        }
      } else {
        _error = 'Las credenciales son incorrectas, intente nuevamente.';
      }
    } catch (e) {
      if (e is DioException) {
        // Error relacionado con la conexión a internet
        if (e.type == DioExceptionType) {
          _error = 'No hay conexión a internet. Verifique su conexión.';
        } else {
          _error = 'Error de red. Intente más tarde.';
        }
      } else if (e is FormatException) {
        _error = 'Formato de datos incorrecto.';
      } else {
        _error = 'Credenciales Incorrectos. Intente nuevamente.';
      }
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

  // Mostrar un diálogo cuando el técnico debe cambiar su contraseña
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
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  // Método de cierre de sesión
  void logout() {
    _tecnico = null;
    isFirstLogin = false;
    _error = null;

    // Limpiar el apiKey de SharedPreferences
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove('apikey');
    });

    notifyListeners();
  }
  
  // Limpiar el estado del LoginBloc
  void clear() {
    _tecnico = null;
    _error = null;
    notifyListeners();
  }
}
