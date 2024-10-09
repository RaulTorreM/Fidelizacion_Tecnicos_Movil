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
      fechaNacimientoTecnico: json['fechaNacimiento_Tecnico'] as String?,
      totalPuntosActualesTecnico:
          (json['totalPuntosActuales_Tecnico'] as num).toInt(),
      historicoPuntosTecnico: (json['historicoPuntos_Tecnico'] as num).toInt(),
      rangoTecnico: json['rangoTecnico'] as String?,
    );

Map<String, dynamic> _$TecnicoToJson(Tecnico instance) => <String, dynamic>{
      'idTecnico': instance.idTecnico,
      'nombreTecnico': instance.nombreTecnico,
      'celularTecnico': instance.celularTecnico,
      'oficioTecnico': instance.oficioTecnico,
      'fechaNacimiento_Tecnico': instance.fechaNacimientoTecnico,
      'totalPuntosActuales_Tecnico': instance.totalPuntosActualesTecnico,
      'historicoPuntos_Tecnico': instance.historicoPuntosTecnico,
      'rangoTecnico': instance.rangoTecnico,
    };
