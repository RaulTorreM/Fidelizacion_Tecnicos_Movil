

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../data/models/login_request.dart' ; // Importar desde models
import '../data/models/login_response.dart' ;
import '../data/models/tecnico.dart' ;
import '../data/models/venta_intermediada.dart';
import '../data/models/csrf_response.dart';
import '../data/models/recompensa.dart';
import '../data/models/tecnico_response.dart';
import '../data/models/solicitud_canje_detalle.dart';
import '../data/models/solicitud_canje_resumen.dart';

part 'api_service.g.dart'; 

@RestApi(baseUrl: "http://192.168.0.15/FidelizacionTecnicos/public/api/")
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) = _ApiService;

  static ApiService create() {
    final dio = Dio();
    dio.options.connectTimeout = Duration(seconds: 5);
    dio.options.receiveTimeout = Duration(seconds: 3);



    // Configurar encabezados globales si es necesario
    dio.options.headers["Content-Type"] = "application/json";
    
    return ApiService(dio);
  }

  @GET("csrf-token")
  Future<CsrfResponse> getCsrfToken();

  @POST("/loginmovil/login-tecnicos")
  Future<LoginResponse> loginTecnico(@Body() LoginRequest loginRequest);


  @GET("/loginmovil/login-DataTecnicos")
  Future<List<Tecnico>> getAllLoginTecnicos();

  @GET("/ventas-intermediadas/{idTecnico}")
  Future<List<VentaIntermediada>> getVentasIntermediadas(@Path("idTecnico") String idTecnico);

  @GET("/getTecnico/{idTecnico}")
  Future<TecnicoResponse> obtenerTecnicoPorId(@Path("idTecnico") String idTecnico);

  @GET("/recompensas")
  Future<List<Recompensa>> obtenerRecompensas();

  @POST("/cambiar-password")
  Future<Map<String, dynamic>> changePassword(
    @Field('idTecnico') String idTecnico, 
    @Field('currentPassword') String currentPassword, 
    @Field('newPassword') String newPassword
  );


  @PUT("/tecnico/{idTecnico}/oficios")
    Future<Map<String, dynamic>> updateJobs(
      @Path("idTecnico") String idTecnico,
      @Body() Map<String, dynamic> requestBody,
    );

  @GET("/oficios")
  Future<List<Oficio>> getAvailableJobs();  

  @POST("/solicitudes/canje")
  Future<Map<String, dynamic>> guardarSolicitudCanje(
    @Body() Map<String, dynamic> solicitudCanje,
  );

  @GET("/solicitudes-canje/{idTecnico}")
  Future<List<SolicitudCanjeResumen>> obtenerSolicitudesCanje(@Path("idTecnico") String idTecnico);

  @GET("/solicitudes-canje/{idSolicitud}/detalles")
  Future<SolicitudCanjeDetalles> obtenerSolicitudCanjeDetalles(@Path("idSolicitud") String idSolicitud);


}

final ApiService _apiService = ApiService.create();
