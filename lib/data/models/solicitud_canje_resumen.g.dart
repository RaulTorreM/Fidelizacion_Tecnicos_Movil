// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solicitud_canje_resumen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SolicitudCanjeResumen _$SolicitudCanjeResumenFromJson(Map json) =>
    SolicitudCanjeResumen(
      idSolicitudCanje: json['idSolicitudCanje'] as String,
      idVentaIntermediada: json['idVentaIntermediada'] as String,
      idTecnico: json['idTecnico'] as String,
      nombre_EstadoSolicitudCanje:
          json['nombre_EstadoSolicitudCanje'] as String?,
      fechaHora_SolicitudCanje: json['fechaHora_SolicitudCanje'] as String?,
      puntosCanjeados_SolicitudCanje:
          (json['puntosCanjeados_SolicitudCanje'] as num).toInt(),
    );

Map<String, dynamic> _$SolicitudCanjeResumenToJson(
        SolicitudCanjeResumen instance) =>
    <String, dynamic>{
      'idSolicitudCanje': instance.idSolicitudCanje,
      'idVentaIntermediada': instance.idVentaIntermediada,
      'idTecnico': instance.idTecnico,
      'nombre_EstadoSolicitudCanje': instance.nombre_EstadoSolicitudCanje,
      'fechaHora_SolicitudCanje': instance.fechaHora_SolicitudCanje,
      'puntosCanjeados_SolicitudCanje': instance.puntosCanjeados_SolicitudCanje,
    };
