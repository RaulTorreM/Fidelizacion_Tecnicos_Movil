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
}
