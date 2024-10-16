import '../../services/api_service.dart';

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
  
}
