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

  @JsonKey(name: 'fechaNacimiento_Tecnico')
  final String? fechaNacimientoTecnico;

  @JsonKey(name: 'totalPuntosActuales_Tecnico')
  final int totalPuntosActualesTecnico;

  @JsonKey(name: 'historicoPuntos_Tecnico')
  final int historicoPuntosTecnico;

  @JsonKey(name: 'rangoTecnico')
  final String? rangoTecnico;

  @JsonKey(name: 'oficios')
  final List<Oficio> oficios;

  Tecnico({
    required this.idTecnico,
    required this.nombreTecnico,
    required this.celularTecnico,
    this.fechaNacimientoTecnico,
    required this.totalPuntosActualesTecnico,
    required this.historicoPuntosTecnico,
    this.rangoTecnico,
    required this.oficios,
  });

  factory Tecnico.fromJson(Map<String, dynamic> json) => _$TecnicoFromJson(json);
  Map<String, dynamic> toJson() => _$TecnicoToJson(this);
}

@JsonSerializable()
class Oficio {
  @JsonKey(name: 'idOficio')
  final int idOficio;

  @JsonKey(name: 'nombreOficio') // Asegúrate que el nombre sea consistente con el JSON
  final String nombreOficio;

  Oficio({required this.idOficio, required this.nombreOficio});

  factory Oficio.fromJson(Map<String, dynamic> json) => _$OficioFromJson(json);
  Map<String, dynamic> toJson() => _$OficioToJson(this);
}
