import '../../services/api_service.dart';
import '../models/solicitud_canje.dart';


class SolicitudCanjeRepository {
  final ApiService apiService;

  SolicitudCanjeRepository({required this.apiService});

  Future<void> guardarSolicitudCanje(SolicitudCanje solicitudCanje) async {
    try {
      await apiService.guardarSolicitudCanje(solicitudCanje.toJson());
    } catch (e) {
      throw Exception('Error al guardar la solicitud de canje: $e');
    }
  }
  Future<List<SolicitudCanje>> obtenerSolicitudesCanje(String idTecnico) async {
    try {
      // Realizar la llamada a la API a través de ApiService
      final solicitudes = await apiService.obtenerSolicitudesCanje(idTecnico);
      
      // Imprimir las solicitudes obtenidas para depuración
      print("Solicitudes obtenidas: $solicitudes");

      return solicitudes;
    } catch (e) {
      print("Error al obtener solicitudes de canje: $e");
      throw Exception('Error al obtener las solicitudes de canje: $e');
    }
  }


  Future<SolicitudCanje> obtenerSolicitudCanjeDetalles(String idSolicitud) async {
    try {
      return await apiService.obtenerSolicitudCanjeDetalles(idSolicitud);
    } catch (e) {
      throw Exception('Error al obtener los detalles de la solicitud de canje: $e');
    }
  }
}
