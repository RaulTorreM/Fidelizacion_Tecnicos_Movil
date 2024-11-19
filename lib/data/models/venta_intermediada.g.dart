// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venta_intermediada.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VentaIntermediada _$VentaIntermediadaFromJson(Map json) => VentaIntermediada(
      idVentaIntermediada: json['idVentaIntermediada'] as String,
      idTecnico: json['idTecnico'] as String,
      nombreTecnico: json['nombreTecnico'] as String,
      tipoCodigoCliente_VentaIntermediada:
          json['tipoCodigoCliente_VentaIntermediada'] as String,
      codigoCliente_VentaIntermediada:
          json['codigoCliente_VentaIntermediada'] as String,
      nombreCliente_VentaIntermediada:
          json['nombreCliente_VentaIntermediada'] as String,
      fechaHoraEmision_VentaIntermediada:
          json['fechaHoraEmision_VentaIntermediada'] as String,
      fechaHoraCargada_VentaIntermediada:
          json['fechaHoraCargada_VentaIntermediada'] as String,
      montoTotal_VentaIntermediada:
          (json['montoTotal_VentaIntermediada'] as num).toDouble(),
      puntosGanados_VentaIntermediada:
          (json['puntosGanados_VentaIntermediada'] as num).toInt(),
      puntosActuales_VentaIntermediada:
          (json['puntosActuales_VentaIntermediada'] as num).toInt(),
      idEstadoVenta: (json['idEstadoVenta'] as num).toInt(),
      estado_nombre: json['estado_nombre'] as String?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
      deleted_at: json['deleted_at'] as String?,
    );

Map<String, dynamic> _$VentaIntermediadaToJson(VentaIntermediada instance) =>
    <String, dynamic>{
      'idVentaIntermediada': instance.idVentaIntermediada,
      'idTecnico': instance.idTecnico,
      'nombreTecnico': instance.nombreTecnico,
      'tipoCodigoCliente_VentaIntermediada':
          instance.tipoCodigoCliente_VentaIntermediada,
      'codigoCliente_VentaIntermediada':
          instance.codigoCliente_VentaIntermediada,
      'nombreCliente_VentaIntermediada':
          instance.nombreCliente_VentaIntermediada,
      'fechaHoraEmision_VentaIntermediada':
          instance.fechaHoraEmision_VentaIntermediada,
      'fechaHoraCargada_VentaIntermediada':
          instance.fechaHoraCargada_VentaIntermediada,
      'montoTotal_VentaIntermediada': instance.montoTotal_VentaIntermediada,
      'puntosGanados_VentaIntermediada':
          instance.puntosGanados_VentaIntermediada,
      'puntosActuales_VentaIntermediada':
          instance.puntosActuales_VentaIntermediada,
      'idEstadoVenta': instance.idEstadoVenta,
      'estado_nombre': instance.estado_nombre,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'deleted_at': instance.deleted_at,
    };
