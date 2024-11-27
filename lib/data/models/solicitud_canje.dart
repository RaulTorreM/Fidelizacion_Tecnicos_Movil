import 'package:json_annotation/json_annotation.dart';
import 'solicitud_canje_recompensa.dart';

part 'solicitud_canje.g.dart';

@JsonSerializable()
class SolicitudCanje {
  final String idVentaIntermediada;
  final String idTecnico;
  final List<SolicitudCanjeRecompensa>? recompensas;
  final int puntosCanjeados_SolicitudCanje;

  // Nuevos campos añadidos para compatibilidad con la API
  final String? idSolicitudCanje; // Identificador único de la solicitud
  final String? nombre_EstadoSolicitudCanje; // Nombre del estado del canje
  final String? fechaHora_SolicitudCanje; // Fecha y hora de la solicitud
  final int? idEstadoSolicitudCanje;
  

  SolicitudCanje({

    required this.idVentaIntermediada,
    required this.idTecnico,
    this.recompensas,
    required this.puntosCanjeados_SolicitudCanje,
    this.idSolicitudCanje, // Opcional para no afectar tu otra página
    this.nombre_EstadoSolicitudCanje, // Opcional
    this.fechaHora_SolicitudCanje, // Opcional
    this.idEstadoSolicitudCanje,

  });

  factory SolicitudCanje.fromJson(Map<String, dynamic> json) =>
      _$SolicitudCanjeFromJson(json);

  Map<String, dynamic> toJson() => _$SolicitudCanjeToJson(this);
}
