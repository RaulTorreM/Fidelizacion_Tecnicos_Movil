// lib/logic/ventas_intermediadas_bloc.dart
import 'package:flutter/material.dart';
import '../data/models/venta_intermediada.dart';
import '../data/repositories/venta_intermediada_repository.dart';
import '../services/api_service.dart';

class VentasIntermediadasBloc with ChangeNotifier {
  final VentaIntermediadaRepository _ventaIntermediadaRepository;

  VentasIntermediadasBloc(ApiService apiService)
      : _ventaIntermediadaRepository = VentaIntermediadaRepository(apiService);

  List<VentaIntermediada> _ventasIntermediadas = [];
  String? _error;
  bool _isLoading = false;

  List<VentaIntermediada> get ventasIntermediadas => _ventasIntermediadas;
  String? get error => _error;
  bool get isLoading => _isLoading;

  // Método para obtener ventas intermediadas
  Future<void> fetchVentasIntermediadas(String idTecnico) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _ventasIntermediadas = await _ventaIntermediadaRepository.obtenerVentasIntermediadas(idTecnico);
      _error = null;
    } catch (e) {
      _ventasIntermediadas = [];
      _error = 'Error al obtener ventas intermediadas: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Limpiar error y lista de ventas
  void clear() {
    _ventasIntermediadas = [];
    _error = null;
    notifyListeners();
  }
}
