import '../models/login_request.dart'; // Importar desde models
import '../models/login_response.dart';
import '../models/tecnico.dart';
import '../../services/api_service.dart'; // Importar servicio
import 'package:dio/dio.dart';

class TecnicoRepository {
  final ApiService _apiService;

  // Constructor para inicializar el servicio
  TecnicoRepository(this._apiService);

  // Método para login del técnico
  Future<LoginResponse> loginTecnico(LoginRequest loginRequest) async {
    try {
      
      // Asegurarnos de que el servicio reciba la solicitud de login
      print('LoginRequest: ${loginRequest.toJson()}');
      final response = await _apiService.loginTecnico(loginRequest);
      return response;
    } catch (e) {
      if (e is DioException) {
        print('Error: ${e.response?.data}'); // Imprime la respuesta del servidor
        print('Status Code: ${e.response?.statusCode}');
      } else {
        print('Error desconocido: $e');
      }
      throw Exception('Error al iniciar sesión: $e');
    }
  }

  // Método para obtener la lista de técnicos
  Future<List<Tecnico>> obtenerTecnicos() async {
    try {
      final response = await _apiService.getAllTecnicos();
      return response;
    } catch (e) {
      throw Exception('Error al obtener técnicos: $e');
    }
  }

 
   // Método para obtener detalles de un técnico específico
  Future<Tecnico> obtenerTecnicoPorId(String idTecnico) async {
    try {
      final response = await _apiService.obtenerTecnicoPorId(idTecnico);
      return response.tecnico; // Asegúrate de que la respuesta esté correctamente definida.
    } catch (e) {
      print("Error en el repositorio al obtener el técnico: $e");
      rethrow;
    }
}



}
