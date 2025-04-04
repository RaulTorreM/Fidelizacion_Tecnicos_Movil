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
      final response = await _apiService.loginTecnico(loginRequest);
      
      return response;
    } catch (e) {
      if (e is DioException) {

      } else {

      }
      throw Exception('Error al iniciar sesión: $e');
    }
  }

  // Método para obtener la lista de técnicos
  Future<List<Tecnico>> obtenerTecnicos() async {
    try {
      final response = await _apiService.getAllLoginTecnicos();
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

      rethrow;
    }
}



}
