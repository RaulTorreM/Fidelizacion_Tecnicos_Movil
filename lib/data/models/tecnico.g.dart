// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tecnico.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tecnico _$TecnicoFromJson(Map<String, dynamic> json) => Tecnico(
      idTecnico: json['idTecnico'] as String,
      nombreTecnico: json['nombreTecnico'] as String,
      celularTecnico: json['celularTecnico'] as String,
      oficioTecnico: json['oficioTecnico'] as String,
      fechaNacimientoTecnico: json['fechaNacimientoTecnico'] as String,
      totalPuntosActualesTecnico:
          (json['totalPuntosActualesTecnico'] as num).toInt(),
      historicoPuntosTecnico: (json['historicoPuntosTecnico'] as num).toInt(),
      rangoTecnico: json['rangoTecnico'] as String,
    );

Map<String, dynamic> _$TecnicoToJson(Tecnico instance) => <String, dynamic>{
      'idTecnico': instance.idTecnico,
      'nombreTecnico': instance.nombreTecnico,
      'celularTecnico': instance.celularTecnico,
      'oficioTecnico': instance.oficioTecnico,
      'fechaNacimientoTecnico': instance.fechaNacimientoTecnico,
      'totalPuntosActualesTecnico': instance.totalPuntosActualesTecnico,
      'historicoPuntosTecnico': instance.historicoPuntosTecnico,
      'rangoTecnico': instance.rangoTecnico,
    };
