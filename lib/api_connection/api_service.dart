import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:dio/io.dart';
import 'dart:io';

part 'api_service.g.dart';

@RestApi(baseUrl: "http://192.168.0.15/FidelizacionTecnicos/public/")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  static ApiService create() {
    final dio = Dio();
    dio.options.connectTimeout = Duration(seconds: 5);
    dio.options.receiveTimeout = Duration(seconds: 3);

    // Desactivar la verificación de certificados (solo para desarrollo)
    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };

    return ApiService(dio);
  }

  @POST("/loginmovil/login-tecnico")
  Future<LoginResponse> login(@Body() LoginRequest loginRequest);

  @GET("/loginmovil/login-DataTecnico")
  Future<List<Tecnico>> getAllTecnicos();
}

@JsonSerializable()
class LoginRequest {
  String idTecnico;
  String password;

  LoginRequest({required this.idTecnico, required this.password});

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable()
class LoginResponse {
  String status;
  String message;
  String? idTecnico;

  LoginResponse({required this.status, required this.message, this.idTecnico});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class Tecnico {
  String idTecnico;

  Tecnico({required this.idTecnico});

  factory Tecnico.fromJson(Map<String, dynamic> json) => _$TecnicoFromJson(json);
  Map<String, dynamic> toJson() => _$TecnicoToJson(this);
}

final ApiService _apiService = ApiService.create();
