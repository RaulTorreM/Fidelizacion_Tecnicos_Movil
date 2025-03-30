// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_venta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TecnicoNotification _$TecnicoNotificationFromJson(Map json) =>
    TecnicoNotification(
      id: (json['id'] as num).toInt(),
      idTecnico: json['idTecnico'] as String,
      idVentaIntermediada: json['idVentaIntermediada'] as String?,
      description: json['description'] as String,
      active:
          TecnicoNotification._activeFromJson((json['active'] as num).toInt()),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$TecnicoNotificationToJson(
        TecnicoNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'idTecnico': instance.idTecnico,
      'idVentaIntermediada': instance.idVentaIntermediada,
      'description': instance.description,
      'active': TecnicoNotification._activeToJson(instance.active),
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
