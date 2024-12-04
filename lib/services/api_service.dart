import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/login_request.dart';
import '../data/models/login_response.dart';
import '../data/models/tecnico.dart';
import '../data/models/venta_intermediada.dart';
import '../data/models/csrf_response.dart';
import '../data/models/recompensa.dart';
import '../data/models/tecnico_response.dart';
import '../data/models/solicitud_canje_detalle.dart';
import '../data/models/solicitud_canje_resumen.dart';

part 'api_service.g.dart';


@RestApi(baseUrl: "https://clubtecnicosdimacof.site/api/")
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) = _ApiService;

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
    @Field('newPassword') String newPassword,
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

class DioInstance {
  static final DioInstance _instance = DioInstance._internal();
  final Dio dio = Dio();

  factory DioInstance() {
    return _instance;
  }

  DioInstance._internal() {
    dio.options.baseUrl = "https://clubtecnicosdimacof.site/api/";
    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.receiveTimeout = const Duration(seconds: 3);
    dio.options.headers["Content-Type"] = "application/json";

    // Interceptor para manejar Authorization
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final apiKey = prefs.getString('apikey')?.trim();


        if (apiKey != null) {
          options.headers["Authorization"] = apiKey; 
        } else {
          options.headers.remove("Authorization");
        }

        return handler.next(options); // Continuar con la solicitud
      },
      onError: (DioException e, handler) {
        if (e.response?.statusCode == 401) {
          print("Error 401: No autorizado. Verifica la API Key.");
        }
        return handler.next(e); // Continuar manejando el error
      },
    ));
  }

  ApiService getApiService() {
    return ApiService(dio);
  }
}
