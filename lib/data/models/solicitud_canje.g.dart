// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solicitud_canje.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SolicitudCanje _$SolicitudCanjeFromJson(Map json) => SolicitudCanje(
      idVentaIntermediada: json['idVentaIntermediada'] as String,
      idTecnico: json['idTecnico'] as String,
      recompensas: (json['recompensas'] as List<dynamic>)
          .map((e) => SolicitudCanjeRecompensa.fromJson(
              Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$SolicitudCanjeToJson(SolicitudCanje instance) =>
    <String, dynamic>{
      'idVentaIntermediada': instance.idVentaIntermediada,
      'idTecnico': instance.idTecnico,
      'recompensas': instance.recompensas,
    };