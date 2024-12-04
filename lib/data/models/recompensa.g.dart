// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recompensa.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recompensa _$RecompensaFromJson(Map json) => Recompensa(
      idRecompensa: json['idRecompensa'] as String,
      tipoRecompensa: json['tipoRecompensa'] as String,
      descripcionRecompensa: json['descripcionRecompensa'] as String,
      costoPuntos_Recompensa: (json['costoPuntos_Recompensa'] as num).toInt(),
      stock_Recompensa: (json['stock_Recompensa'] as num).toInt(),
    );

Map<String, dynamic> _$RecompensaToJson(Recompensa instance) =>
    <String, dynamic>{
      'idRecompensa': instance.idRecompensa,
      'tipoRecompensa': instance.tipoRecompensa,
      'descripcionRecompensa': instance.descripcionRecompensa,
      'costoPuntos_Recompensa': instance.costoPuntos_Recompensa,
      'stock_Recompensa': instance.stock_Recompensa,
    };
