// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solicitud_canje.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SolicitudCanje _$SolicitudCanjeFromJson(Map json) => SolicitudCanje(
      idVentaIntermediada: json['idVentaIntermediada'] as String,
      idTecnico: json['idTecnico'] as String,
      recompensas: (json['recompensas'] as List<dynamic>?)
          ?.map((e) => SolicitudCanjeRecompensa.fromJson(
              Map<String, dynamic>.from(e as Map)))
          .toList(),
      puntosCanjeados_SolicitudCanje:
          (json['puntosCanjeados_SolicitudCanje'] as num).toInt(),
      idSolicitudCanje: json['idSolicitudCanje'] as String?,
      nombre_EstadoSolicitudCanje:
          json['nombre_EstadoSolicitudCanje'] as String?,
      fechaHora_SolicitudCanje: json['fechaHora_SolicitudCanje'] as String?,
      idEstadoSolicitudCanje: (json['idEstadoSolicitudCanje'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SolicitudCanjeToJson(SolicitudCanje instance) =>
    <String, dynamic>{
      'idVentaIntermediada': instance.idVentaIntermediada,
      'idTecnico': instance.idTecnico,
      'recompensas': instance.recompensas,
      'puntosCanjeados_SolicitudCanje': instance.puntosCanjeados_SolicitudCanje,
      'idSolicitudCanje': instance.idSolicitudCanje,
      'nombre_EstadoSolicitudCanje': instance.nombre_EstadoSolicitudCanje,
      'fechaHora_SolicitudCanje': instance.fechaHora_SolicitudCanje,
      'idEstadoSolicitudCanje': instance.idEstadoSolicitudCanje,
    };
