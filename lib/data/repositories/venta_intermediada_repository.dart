import '../models/venta_intermediada.dart';
import '../../services/api_service.dart';

class VentaIntermediadaRepository {
  final ApiService _apiService;

  VentaIntermediadaRepository(this._apiService);

  Future<List<VentaIntermediada>> obtenerVentasIntermediadas(String idTecnico) async {
    try {
      // Llamada a la API para obtener las ventas intermediadas por idTecnico
      final response = await _apiService.getVentasIntermediadas(idTecnico);
      return response;
    } catch (e) {
      throw Exception('Error al obtener ventas intermediadas: $e');
    }
  }

   Future<List<VentaIntermediada>> obtenerIntermediadasSolicitudes(String idTecnico) async {
    try {
      // Llamada a la API para obtener las ventas intermediadas por idTecnico
      final response = await _apiService.getVentasIntermediadasSolicitudes(idTecnico);
      return response;
    } catch (e) {
      throw Exception('Error al obtener ventas intermediadas: $e');
    }
  }

  
  
}
