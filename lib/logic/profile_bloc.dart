// lib/logic/perfil_bloc.dart
import 'package:flutter/material.dart';
import '../data/models/tecnico.dart';
import '../data/repositories/tecnico_repository.dart';
import '../services/api_service.dart';
import '../data/repositories/perfil_repository.dart';

class PerfilBloc with ChangeNotifier {
  final TecnicoRepository _tecnicoRepository;
  final PerfilRepository perfilRepository;

  PerfilBloc(ApiService apiService, this.perfilRepository)
      : _tecnicoRepository = TecnicoRepository(apiService);

  Tecnico? _tecnico;
  String? _error;
  bool _isLoading = false;

  Tecnico? get tecnico => _tecnico;
  String? get error => _error;
  bool get isLoading => _isLoading;

  // Método para obtener el perfil del técnico
  Future<void> fetchPerfil(String idTecnico) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _tecnico = await _tecnicoRepository.obtenerTecnicoPorId(idTecnico); // Asegúrate de que tengas este método
      _error = null;
    } catch (e) {
      _tecnico = null;
      _error = 'Error al obtener perfil: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Limpiar error y perfil
  void clear() {
    _tecnico = null;
    _error = null;
    notifyListeners();
  }

  Future<void> changePassword(String idTecnico, String currentPassword, String newPassword) async {
    final response = await perfilRepository.changePassword(idTecnico, currentPassword, newPassword);

    if (response['status'] == 'success') {
      // Notificar éxito
      notifyListeners();
    } else {
      // Capturar el error
      _error = response['message'];
      notifyListeners();
    }
  }

  Future<void> changeJobs(String idTecnico, List<int> oficios, String password) async {
    try {
      // Llamar al repositorio para actualizar los oficios
      final response = await perfilRepository.updateJobs(idTecnico, oficios, password);

      // Aquí puedes agregar el código para manejar la respuesta de éxito
      if (response['message'] == 'Oficios actualizados correctamente') {
        
        _error = response['message'];
        notifyListeners();
      }
    } catch (e) {
  
      _error = 'Error al cambiar oficios: ${e.toString()}';
      notifyListeners();
    }
  }
}
