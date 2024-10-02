import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "http://192.168.0.15/FidelizacionTecnicos/public/api/")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  static ApiService create() {
    final dio = Dio();


    dio.options.connectTimeout = Duration(seconds: 5);
    dio.options.receiveTimeout = Duration(seconds: 3);
    return ApiService(dio);
  }

  @GET("csrf-token")
  Future<CsrfResponse> getCsrfToken();

  @POST("/loginmovil/login-tecnico")
  Future<LoginResponse> loginTecnico(@Body() LoginRequest loginRequest);

  @GET("/loginmovil/login-DataTecnico")
  Future<List<Tecnico>> getAllTecnicos();

  @GET("/ventas-intermediadas/{idTecnico}")
  Future<List<VentaIntermediada>> getVentasIntermediadas(@Path("idTecnico") String idTecnico);
}

@JsonSerializable()
class CsrfResponse {
  String csrf_token;

  CsrfResponse({required this.csrf_token});

  factory CsrfResponse.fromJson(Map<String, dynamic> json) => _$CsrfResponseFromJson(json);
}

@JsonSerializable()
class LoginRequest {
  String celularTecnico;
  String password;

   LoginRequest({required this.celularTecnico, required this.password});

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable()
class LoginResponse {
  String status;
  String message;
  Tecnico? tecnico; // Cambiado para incluir el objeto Tecnico

  LoginResponse({required this.status, required this.message, this.tecnico});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class Tecnico {
  String idTecnico; // Añadido
  String celularTecnico;
  String nombreTecnico;
  String fechaNacimientoTecnico; // Añadido
  int puntosTecnico; // Añadido
  int historicoPuntosTecnico; // Añadido
  String rangoTecnico; // Añadido

  Tecnico({
    required this.idTecnico,
    required this.celularTecnico,
    required this.nombreTecnico,
    required this.fechaNacimientoTecnico,
    required this.puntosTecnico,
    required this.historicoPuntosTecnico,
    required this.rangoTecnico,
  });

  factory Tecnico.fromJson(Map<String, dynamic> json) => _$TecnicoFromJson(json);
  Map<String, dynamic> toJson() => _$TecnicoToJson(this);
}

@JsonSerializable()
class VentaIntermediada {
  String idVentaIntermediada;
  String idTecnico;
  String nombreCliente;
  String tipoCodigoCliente;
  String codigoCliente;
  DateTime fechaHoraEmision;
  DateTime fechaHoraCargada;
  double montoTotal;
  int puntosGanados;
  String estado;

  VentaIntermediada({
    required this.idVentaIntermediada,
    required this.idTecnico,
    required this.nombreCliente,
    required this.tipoCodigoCliente,
    required this.codigoCliente,
    required this.fechaHoraEmision,
    required this.fechaHoraCargada,
    required this.montoTotal,
    required this.puntosGanados,
    required this.estado,
  });

  factory VentaIntermediada.fromJson(Map<String, dynamic> json) {
    return VentaIntermediada(
      idVentaIntermediada: json['idVentaIntermediada'] as String? ?? '',
      idTecnico: json['idTecnico'] as String? ?? '',
      nombreCliente: json['nombreCliente_VentaIntermediada'] as String? ?? 'Sin nombre',
      tipoCodigoCliente: json['tipoCodigoCliente_VentaIntermediada'] as String? ?? '',
      codigoCliente: json['codigoCliente_VentaIntermediada'] as String? ?? '',
      fechaHoraEmision: DateTime.parse(json['fechaHoraEmision_VentaIntermediada'] as String),
      fechaHoraCargada: DateTime.parse(json['fechaHoraCargada_VentaIntermediada'] as String),
      montoTotal: (json['montoTotal_VentaIntermediada'] as num?)?.toDouble() ?? 0.0,
      puntosGanados: json['puntosGanados_VentaIntermediada'] as int? ?? 0,
      estado: json['estadoVentaIntermediada'] as String? ?? 'Desconocido',
    );
  }
}

final ApiService _apiService = ApiService.create();
