// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solicitud_canje_detalle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SolicitudCanjeDetalle _$SolicitudCanjeDetalleFromJson(Map json) =>
    SolicitudCanjeDetalle(
      idSolicitudCanje: json['idSolicitudCanje'] as String,
      idVentaIntermediada: json['idVentaIntermediada'] as String,
      fechaHoraEmisionVentaIntermediada:
          json['fechaHoraEmisionVentaIntermediada'] as String,
      idTecnico: json['idTecnico'] as String,
      idUser: json['idUser'] as String?,
      fechaHoraSolicitudCanje: json['fechaHoraSolicitudCanje'] as String,
      diasTranscurridosSolicitudCanje:
          (json['diasTranscurridosSolicitudCanje'] as num).toInt(),
      puntosComprobanteSolicitudCanje:
          (json['puntosComprobanteSolicitudCanje'] as num).toInt(),
      puntosCanjeadosSolicitudCanje:
          (json['puntosCanjeadosSolicitudCanje'] as num).toInt(),
      puntosRestantesSolicitudCanje:
          (json['puntosRestantesSolicitudCanje'] as num).toInt(),
      comentarioSolicitudCanje: json['comentarioSolicitudCanje'] as String?,
      recompensas: (json['recompensas'] as List<dynamic>)
          .map((e) =>
              RecompensaDetalle.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$SolicitudCanjeDetalleToJson(
        SolicitudCanjeDetalle instance) =>
    <String, dynamic>{
      'idSolicitudCanje': instance.idSolicitudCanje,
      'idVentaIntermediada': instance.idVentaIntermediada,
      'fechaHoraEmisionVentaIntermediada':
          instance.fechaHoraEmisionVentaIntermediada,
      'idTecnico': instance.idTecnico,
      'idUser': instance.idUser,
      'fechaHoraSolicitudCanje': instance.fechaHoraSolicitudCanje,
      'diasTranscurridosSolicitudCanje':
          instance.diasTranscurridosSolicitudCanje,
      'puntosComprobanteSolicitudCanje':
          instance.puntosComprobanteSolicitudCanje,
      'puntosCanjeadosSolicitudCanje': instance.puntosCanjeadosSolicitudCanje,
      'puntosRestantesSolicitudCanje': instance.puntosRestantesSolicitudCanje,
      'comentarioSolicitudCanje': instance.comentarioSolicitudCanje,
      'recompensas': instance.recompensas,
    };
