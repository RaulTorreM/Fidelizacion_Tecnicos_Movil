import '../../services/api_service.dart';


import '../../data/models/tecnico.dart';  // Asegúrate de que la clase Tecnico está importada correctamente

class PerfilRepository {
  final ApiService apiService;

  PerfilRepository(this.apiService);

  // Método para cambiar la contraseña del técnico
  Future<Map<String, dynamic>> changePassword(String idTecnico, String currentPassword, String newPassword) async {
    try {
      final response = await apiService.changePassword(idTecnico, currentPassword, newPassword);
      return response;
    } catch (e) {
      // Manejo de errores
      return {'status': 'error', 'message': 'Ocurrió un error al cambiar la contraseña.'};
    }
  }

  // Método para cambiar el oficio de un técnico (con una sola opción de oficio)
  Future<Map<String, dynamic>> changeJob(String idTecnico, String nuevoOficio, String password) async {
    try {
      final response = await apiService.changeJob(idTecnico, password, nuevoOficio);
      return response;
    } catch (e) {
      // Manejo de errores
      return {'success': false, 'message': 'Error: ${e.toString()}'};
    }
  }

  // Método para actualizar los oficios de un técnico
  Future<Map<String, dynamic>> updateJobs(String idTecnico, List<int> oficios, String password) async {
    try {
      // Crear el cuerpo de la solicitud
      Map<String, dynamic> requestBody = {
        'oficios': oficios,  // Enviar solo los IDs de los oficios
        'password': password,
      };

      // Llamar a la API
      final response = await apiService.updateJobs(idTecnico, requestBody);
      return response;
    } catch (e) {
      throw Exception('Error al actualizar los oficios: $e');
    }
  }

  // Método para obtener los oficios disponibles directamente desde el modelo Tecnico
  Future<List<Oficio>> getAvailableJobs() async {
  try {
    final response = await apiService.getAvailableJobs();  // La API debe retornar la lista completa de oficios
    return response;  // Ya es de tipo List<Oficio>
  } catch (e) {
    throw Exception('Error al obtener los oficios disponibles: $e');
  }
}
}
