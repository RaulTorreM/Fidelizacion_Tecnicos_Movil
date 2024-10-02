// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CsrfResponse _$CsrfResponseFromJson(Map<String, dynamic> json) => CsrfResponse(
      csrf_token: json['csrf_token'] as String,
    );

Map<String, dynamic> _$CsrfResponseToJson(CsrfResponse instance) =>
    <String, dynamic>{
      'csrf_token': instance.csrf_token,
    };

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
      celularTecnico: json['celularTecnico'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'celularTecnico': instance.celularTecnico,
      'password': instance.password,
    };

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      tecnico: json['tecnico'] == null
          ? null
          : Tecnico.fromJson(json['tecnico'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'tecnico': instance.tecnico,
    };

Tecnico _$TecnicoFromJson(Map<String, dynamic> json) => Tecnico(
      idTecnico: json['idTecnico'] as String,
      celularTecnico: json['celularTecnico'] as String,
      nombreTecnico: json['nombreTecnico'] as String,
      fechaNacimientoTecnico: json['fechaNacimientoTecnico'] as String,
      puntosTecnico: (json['puntosTecnico'] as num).toInt(),
      historicoPuntosTecnico: (json['historicoPuntosTecnico'] as num).toInt(),
      rangoTecnico: json['rangoTecnico'] as String,
    );

Map<String, dynamic> _$TecnicoToJson(Tecnico instance) => <String, dynamic>{
      'idTecnico': instance.idTecnico,
      'celularTecnico': instance.celularTecnico,
      'nombreTecnico': instance.nombreTecnico,
      'fechaNacimientoTecnico': instance.fechaNacimientoTecnico,
      'puntosTecnico': instance.puntosTecnico,
      'historicoPuntosTecnico': instance.historicoPuntosTecnico,
      'rangoTecnico': instance.rangoTecnico,
    };

VentaIntermediada _$VentaIntermediadaFromJson(Map<String, dynamic> json) =>
    VentaIntermediada(
      idVentaIntermediada: json['idVentaIntermediada'] as String,
      idTecnico: json['idTecnico'] as String,
      nombreCliente: json['nombreCliente'] as String,
      tipoCodigoCliente: json['tipoCodigoCliente'] as String,
      codigoCliente: json['codigoCliente'] as String,
      fechaHoraEmision: DateTime.parse(json['fechaHoraEmision'] as String),
      fechaHoraCargada: DateTime.parse(json['fechaHoraCargada'] as String),
      montoTotal: (json['montoTotal'] as num).toDouble(),
      puntosGanados: (json['puntosGanados'] as num).toInt(),
      estado: json['estado'] as String,
    );

Map<String, dynamic> _$VentaIntermediadaToJson(VentaIntermediada instance) =>
    <String, dynamic>{
      'idVentaIntermediada': instance.idVentaIntermediada,
      'idTecnico': instance.idTecnico,
      'nombreCliente': instance.nombreCliente,
      'tipoCodigoCliente': instance.tipoCodigoCliente,
      'codigoCliente': instance.codigoCliente,
      'fechaHoraEmision': instance.fechaHoraEmision.toIso8601String(),
      'fechaHoraCargada': instance.fechaHoraCargada.toIso8601String(),
      'montoTotal': instance.montoTotal,
      'puntosGanados': instance.puntosGanados,
      'estado': instance.estado,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiService implements ApiService {
  _ApiService(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'http://192.168.0.15/FidelizacionTecnicos/public/api/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<CsrfResponse> getCsrfToken() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<CsrfResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'csrf-token',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = CsrfResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LoginResponse> loginTecnico(LoginRequest loginRequest) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(loginRequest.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<LoginResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/loginmovil/login-tecnico',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = LoginResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<Tecnico>> getAllTecnicos() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result =
        await _dio.fetch<List<dynamic>>(_setStreamType<List<Tecnico>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/loginmovil/login-DataTecnico',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) => Tecnico.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<VentaIntermediada>> getVentasIntermediadas(
      String idTecnico) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<VentaIntermediada>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/ventas-intermediadas/${idTecnico}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) =>
            VentaIntermediada.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
