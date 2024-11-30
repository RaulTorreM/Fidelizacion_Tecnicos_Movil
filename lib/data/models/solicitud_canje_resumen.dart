import 'package:json_annotation/json_annotation.dart';

part 'solicitud_canje_resumen.g.dart';

@JsonSerializable()
class SolicitudCanjeResumen {
  final String idSolicitudCanje;
  final String idVentaIntermediada;
  final String idTecnico;
  final String? nombre_EstadoSolicitudCanje;
  final String? fechaHora_SolicitudCanje;
  final int puntosCanjeados_SolicitudCanje;

  SolicitudCanjeResumen({
    required this.idSolicitudCanje,
    required this.idVentaIntermediada,
    required this.idTecnico,
    this.nombre_EstadoSolicitudCanje,
    this.fechaHora_SolicitudCanje,
    required this.puntosCanjeados_SolicitudCanje,
  });

  factory SolicitudCanjeResumen.fromJson(Map<String, dynamic> json) =>
      _$SolicitudCanjeResumenFromJson(json);

  Map<String, dynamic> toJson() => _$SolicitudCanjeResumenToJson(this);
}
