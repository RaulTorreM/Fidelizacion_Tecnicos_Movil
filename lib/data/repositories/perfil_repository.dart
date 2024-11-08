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
  Future<void> updateJobs(String idTecnico, List<int> oficios, String password) async {
  try {
    // Cuerpo de la solicitud
    Map<String, dynamic> requestBody = {
      'idTecnico': idTecnico,
      'oficios': oficios, // Lista de IDs de oficios
      'password': password,
    };

    // Llamada a la API usando ApiService
    final response = await apiService.updateJobs(idTecnico, requestBody);

    if (response.containsKey('message') && response['message'] == 'Oficios actualizados correctamente') {
      print('Oficios actualizados en la API con éxito');
      // Aquí puedes actualizar el estado o mostrar un mensaje de éxito en la UI
    } else {
      throw Exception('Error en la respuesta de la API');
    }
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
