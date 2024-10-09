import 'package:json_annotation/json_annotation.dart';

part 'tecnico.g.dart';

@JsonSerializable()
class Tecnico {
  final String idTecnico;
  final String nombreTecnico;
  final String celularTecnico;
  final String oficioTecnico;
  final String fechaNacimientoTecnico;
  final int totalPuntosActualesTecnico;
  final int historicoPuntosTecnico;
  final String rangoTecnico;

  Tecnico({
    required this.idTecnico,
    required this.nombreTecnico,
    required this.celularTecnico,
    required this.oficioTecnico,
    required this.fechaNacimientoTecnico,
    required this.totalPuntosActualesTecnico,
    required this.historicoPuntosTecnico,
    required this.rangoTecnico,
  });

  factory Tecnico.fromJson(Map<String, dynamic> json) {
    return Tecnico(
      idTecnico: json['idTecnico'],
      nombreTecnico: json['nombreTecnico'],
      celularTecnico: json['celularTecnico'],
      oficioTecnico: json['oficioTecnico'],
      fechaNacimientoTecnico: json['fechaNacimiento_Tecnico'],
      totalPuntosActualesTecnico: json['totalPuntosActuales_Tecnico'],
      historicoPuntosTecnico: json['historicoPuntos_Tecnico'],
      rangoTecnico: json['rangoTecnico'],
    );
  }
}
