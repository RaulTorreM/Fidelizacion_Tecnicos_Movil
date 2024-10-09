// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venta_intermediada.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
