// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recompensa.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recompensa _$RecompensaFromJson(Map<String, dynamic> json) => Recompensa(
      idRecompensa: json['idRecompensa'] as String,
      tipoRecompensa: json['tipoRecompensa'] as String,
      descripcionRecompensa: json['descripcionRecompensa'] as String,
      costoPuntosRecompensa: (json['costoPuntosRecompensa'] as num).toInt(),
    );

Map<String, dynamic> _$RecompensaToJson(Recompensa instance) =>
    <String, dynamic>{
      'idRecompensa': instance.idRecompensa,
      'tipoRecompensa': instance.tipoRecompensa,
      'descripcionRecompensa': instance.descripcionRecompensa,
      'costoPuntosRecompensa': instance.costoPuntosRecompensa,
    };
