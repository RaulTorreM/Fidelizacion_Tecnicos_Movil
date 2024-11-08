// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tecnico.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tecnico _$TecnicoFromJson(Map<String, dynamic> json) => Tecnico(
      idTecnico: json['idTecnico'] as String,
      nombreTecnico: json['nombreTecnico'] as String,
      celularTecnico: json['celularTecnico'] as String,
      fechaNacimientoTecnico: json['fechaNacimiento_Tecnico'] as String?,
      totalPuntosActualesTecnico:
          (json['totalPuntosActuales_Tecnico'] as num).toInt(),
      historicoPuntosTecnico: (json['historicoPuntos_Tecnico'] as num).toInt(),
      rangoTecnico: json['rangoTecnico'] as String?,
      oficios: (json['oficios'] as List<dynamic>)
          .map((e) => Oficio.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TecnicoToJson(Tecnico instance) => <String, dynamic>{
      'idTecnico': instance.idTecnico,
      'nombreTecnico': instance.nombreTecnico,
      'celularTecnico': instance.celularTecnico,
      'fechaNacimiento_Tecnico': instance.fechaNacimientoTecnico,
      'totalPuntosActuales_Tecnico': instance.totalPuntosActualesTecnico,
      'historicoPuntos_Tecnico': instance.historicoPuntosTecnico,
      'rangoTecnico': instance.rangoTecnico,
      'oficios': instance.oficios,
    };

Oficio _$OficioFromJson(Map<String, dynamic> json) => Oficio(
      idOficio: (json['idOficio'] as num).toInt(),
      nombreOficio: json['nombre_Oficio'] as String,
    );

Map<String, dynamic> _$OficioToJson(Oficio instance) => <String, dynamic>{
      'idOficio': instance.idOficio,
      'nombre_Oficio': instance.nombreOficio,
    };
