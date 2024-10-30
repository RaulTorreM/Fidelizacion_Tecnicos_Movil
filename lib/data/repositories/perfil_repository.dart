import '../../services/api_service.dart';

import 'package:dio/dio.dart';

class PerfilRepository {
  final ApiService apiService;

  PerfilRepository(this.apiService);

  Future<Map<String, dynamic>> changePassword(String idTecnico, String currentPassword, String newPassword) async {
    try {
      final response = await apiService.changePassword(idTecnico, currentPassword, newPassword);
      return response;
    } catch (e) {
      // Manejo de errores
      return {'status': 'error', 'message': 'Ocurrió un error al cambiar la contraseña.'};
    }
  }

  Future<Map<String, dynamic>> changeJob(String idTecnico, String nuevoOficio, String password) async {
    try {
      final response = await apiService.changeJob(idTecnico, password, nuevoOficio);
      return response;
    } catch (e) {
      // Manejo de errores
      return {'success': false, 'message': 'Error: ${e.toString()}'};
    }
  }


  
}
