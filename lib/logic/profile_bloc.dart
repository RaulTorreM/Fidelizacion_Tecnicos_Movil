import 'package:flutter/material.dart';
import '../data/repositories/perfil_repository.dart';
import '../data/models/tecnico.dart';  // Asegúrate de que el modelo Tecnico esté bien importado

class ProfileBloc extends ChangeNotifier {
  final PerfilRepository perfilRepository;
  Tecnico? _tecnico; // Almacenará los datos del perfil
  String? _message;  // Para almacenar mensajes de éxito o error
  bool _isLoading = false; // Para controlar el estado de carga
  String? _error;  // Agregar error explícito

  ProfileBloc(this.perfilRepository);

  Tecnico? get tecnico => _tecnico;
  String? get message => _message;
  bool get isLoading => _isLoading;
   String? get error => _error;  

  // Método para obtener el perfil del técnico
  Future<void> fetchPerfil(String idTecnico) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      final response = await perfilRepository.obtenerTecnicoPorId(idTecnico);  // Asegúrate de que el método getPerfil esté en tu repositorio
      _tecnico = response;
      _message = 'Perfil cargado correctamente';
    } catch (e) {
      _tecnico = null;
      _message = 'Error al cargar el perfil: ${e.toString()}';
    }
    
    _isLoading = false;
    notifyListeners();
  }

  // Método para cambiar los oficios de un técnico
  Future<void> changeJobs(String idTecnico, List<int> oficios, String password) async {
    try {
      final response = await perfilRepository.updateJobs(idTecnico, oficios, password);

      if (response['status'] == 'success') {
        _message = response['message'];
      } else {
        _message = response['message'] ?? 'Error desconocido al actualizar los oficios';
      }

      notifyListeners();
    } catch (e) {
      _message = 'Error al cambiar oficios: ${e.toString()}';
      notifyListeners();
    }
  }

  // Método para cambiar la contraseña del técnico
  Future<void> changePassword(String idTecnico, String currentPassword, String newPassword) async {
    try {
      final response = await perfilRepository.changePassword(idTecnico, currentPassword, newPassword);

      if (response['status'] == 'success') {
        _message = response['message'];
      } else {
        _message = response['message'] ?? 'Error desconocido al cambiar la contraseña';
      }

      notifyListeners();
    } catch (e) {
      _message = 'Error al cambiar la contraseña: ${e.toString()}';
      notifyListeners();
    }
  }

  // Método para limpiar el mensaje después de mostrarlo
  void clearMessage() {
    _message = null;
    notifyListeners();
  }
}
