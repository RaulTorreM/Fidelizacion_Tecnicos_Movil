import 'package:json_annotation/json_annotation.dart';

part 'tecnico.g.dart';

@JsonSerializable()
class Tecnico {
  @JsonKey(name: 'idTecnico')
  final String idTecnico;

  @JsonKey(name: 'nombreTecnico')
  final String nombreTecnico;

  @JsonKey(name: 'celularTecnico')
  final String celularTecnico;

  @JsonKey(name: 'oficioTecnico')
  final String oficioTecnico;

  @JsonKey(name: 'fechaNacimiento_Tecnico')
  final String? fechaNacimientoTecnico; // Cambiado el nombre de la clave

  @JsonKey(name: 'totalPuntosActuales_Tecnico')
  final int totalPuntosActualesTecnico; // Cambiado el nombre de la clave

  @JsonKey(name: 'historicoPuntos_Tecnico')
  final int historicoPuntosTecnico; // Cambiado el nombre de la clave

  @JsonKey(name: 'rangoTecnico')
  final String? rangoTecnico; // Campo opcional

  Tecnico({
    required this.idTecnico,
    required this.nombreTecnico,
    required this.celularTecnico,
    required this.oficioTecnico,
    this.fechaNacimientoTecnico, // Campo opcional
    required this.totalPuntosActualesTecnico,
    required this.historicoPuntosTecnico,
    this.rangoTecnico, // Campo opcional
  });

  // Método para deserializar el JSON
  factory Tecnico.fromJson(Map<String, dynamic> json) => _$TecnicoFromJson(json);

  // Método para serializar el objeto a JSON
  Map<String, dynamic> toJson() => _$TecnicoToJson(this);
}
