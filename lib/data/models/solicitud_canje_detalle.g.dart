// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solicitud_canje_detalle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SolicitudCanjeDetalles _$SolicitudCanjeDetallesFromJson(Map json) =>
    SolicitudCanjeDetalles(
      idSolicitudCanje: json['idSolicitudCanje'] as String,
      idVentaIntermediada: json['idVentaIntermediada'] as String,
      fechaHoraEmision_VentaIntermediada:
          json['fechaHoraEmision_VentaIntermediada'] as String,
      idTecnico: json['idTecnico'] as String,
      idUser: json['idUser'] as String?,
      fechaHora_SolicitudCanje: json['fechaHora_SolicitudCanje'] as String,
      diasTranscurridos_SolicitudCanje:
          (json['diasTranscurridos_SolicitudCanje'] as num).toInt(),
      puntosComprobante_SolicitudCanje:
          (json['puntosComprobante_SolicitudCanje'] as num).toInt(),
      puntosCanjeados_SolicitudCanje:
          (json['puntosCanjeados_SolicitudCanje'] as num).toInt(),
      puntosRestantes_SolicitudCanje:
          (json['puntosRestantes_SolicitudCanje'] as num).toInt(),
      comentario_SolicitudCanje: json['comentario_SolicitudCanje'] as String?,
      nombre_EstadoSolicitudCanje:
          json['nombre_EstadoSolicitudCanje'] as String,
      recompensas: (json['recompensas'] as List<dynamic>)
          .map((e) =>
              RecompensaDetalle.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$SolicitudCanjeDetallesToJson(
        SolicitudCanjeDetalles instance) =>
    <String, dynamic>{
      'idSolicitudCanje': instance.idSolicitudCanje,
      'idVentaIntermediada': instance.idVentaIntermediada,
      'fechaHoraEmision_VentaIntermediada':
          instance.fechaHoraEmision_VentaIntermediada,
      'idTecnico': instance.idTecnico,
      'idUser': instance.idUser,
      'fechaHora_SolicitudCanje': instance.fechaHora_SolicitudCanje,
      'diasTranscurridos_SolicitudCanje':
          instance.diasTranscurridos_SolicitudCanje,
      'puntosComprobante_SolicitudCanje':
          instance.puntosComprobante_SolicitudCanje,
      'puntosCanjeados_SolicitudCanje': instance.puntosCanjeados_SolicitudCanje,
      'puntosRestantes_SolicitudCanje': instance.puntosRestantes_SolicitudCanje,
      'comentario_SolicitudCanje': instance.comentario_SolicitudCanje,
      'nombre_EstadoSolicitudCanje': instance.nombre_EstadoSolicitudCanje,
      'recompensas': instance.recompensas,
    };
