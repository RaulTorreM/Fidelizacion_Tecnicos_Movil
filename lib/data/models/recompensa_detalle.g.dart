// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recompensa_detalle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecompensaDetalle _$RecompensaDetalleFromJson(Map json) => RecompensaDetalle(
      idRecompensa: json['idRecompensa'] as String,
      cantidad: (json['cantidad'] as num).toInt(),
      costoRecompensa: (json['costoRecompensa'] as num).toInt(),
      nombreRecompensa: json['nombreRecompensa'] as String,
    );

Map<String, dynamic> _$RecompensaDetalleToJson(RecompensaDetalle instance) =>
    <String, dynamic>{
      'idRecompensa': instance.idRecompensa,
      'cantidad': instance.cantidad,
      'costoRecompensa': instance.costoRecompensa,
      'nombreRecompensa': instance.nombreRecompensa,
    };
