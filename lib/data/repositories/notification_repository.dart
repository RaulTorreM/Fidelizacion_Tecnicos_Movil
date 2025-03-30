import '../../services/api_service.dart';

import '../../data/models/notification_venta.dart';  // Asegúrate de que la clase Tecnico está importada correctamente

class NotificationRepository {
  final ApiService _apiService;

  NotificationRepository(this._apiService);

  Future<List<TecnicoNotification>> getNotifications(String idTecnico) async {
    try {
      final response = await _apiService.getNotifications(idTecnico);
      // print('Notificaciones recibidas: ${response.length}');
      return response;
    } catch (e, stackTrace) {
      print('Error en repository: $e');
      print('Stack trace: $stackTrace');
      throw Exception('Error obteniendo notificaciones: $e');
    }
  }
}