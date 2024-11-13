import '../../services/api_service.dart';

import '../../data/models/tecnico_response.dart';
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


  // Método para actualizar los oficios de un técnico
  Future<Map<String, dynamic>> updateJobs(String idTecnico, List<int> oficios, String password) async {
    try {
      Map<String, dynamic> requestBody = {
        'idTecnico': idTecnico,
        'oficios': oficios,
        'password': password,
      };

      final response = await apiService.updateJobs(idTecnico, requestBody);

      if (response.containsKey('message') && response['message'] == 'Oficios actualizados correctamente') {
        return {'status': 'success', 'message': 'Oficios actualizados correctamente'};
      } else {
        return {'status': 'error', 'message': 'Error en la respuesta de la API'};
      }
    } catch (e) {
      return {'status': 'error', 'message': 'Error al actualizar los oficios: $e'};
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
  // Método para obtener detalles de un técnico específico
  Future<Tecnico> obtenerTecnicoPorId(String idTecnico) async {
    try {
      final response = await apiService.obtenerTecnicoPorId(idTecnico);
      return response.tecnico; 
    } catch (e) {
      print("Error en el repositorio al obtener el técnico: $e");
      rethrow;
    }

  }

}