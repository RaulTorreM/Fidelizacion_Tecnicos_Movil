import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../data/models/recompensa.dart';

class RecompensaBloc extends ChangeNotifier {
  List<Recompensa> _recompensas = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Recompensa> get recompensas => _recompensas;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> obtenerRecompensas() async {
    _isLoading = true;
    notifyListeners();

    try {
      _recompensas = await ApiService.create().obtenerRecompensas();
      _errorMessage = null; // Limpiar errores
    } catch (error) {
      _errorMessage = 'Error al cargar recompensas: $error';
      _recompensas = []; // Limpiar recompensas en caso de error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}