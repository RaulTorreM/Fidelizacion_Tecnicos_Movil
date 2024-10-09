// lib/logic/perfil_bloc.dart
import 'package:flutter/material.dart';
import '../data/models/tecnico.dart';
import '../data/repositories/tecnico_repository.dart';
import '../services/api_service.dart';

class PerfilBloc with ChangeNotifier {
  final TecnicoRepository _tecnicoRepository;

  PerfilBloc(ApiService apiService)
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
}
