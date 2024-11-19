// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solicitud_canje_recompensa.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SolicitudCanjeRecompensa _$SolicitudCanjeRecompensaFromJson(Map json) =>
    SolicitudCanjeRecompensa(
      idRecompensa: json['idRecompensa'] as String,
      cantidad: (json['cantidad'] as num).toInt(),
      costoRecompensa: (json['costoRecompensa'] as num).toDouble(),
    );

Map<String, dynamic> _$SolicitudCanjeRecompensaToJson(
        SolicitudCanjeRecompensa instance) =>
    <String, dynamic>{
      'idRecompensa': instance.idRecompensa,
      'cantidad': instance.cantidad,
      'costoRecompensa': instance.costoRecompensa,
    };
