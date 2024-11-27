import 'package:json_annotation/json_annotation.dart';
import 'solicitud_canje_recompensa.dart'; // Importamos el modelo relacionado.

part 'solicitud_canje.g.dart';

@JsonSerializable()
class SolicitudCanje {
  final String idVentaIntermediada;
  final String idTecnico;
  final List<SolicitudCanjeRecompensa> recompensas;
  final int puntosCanjeados_SolicitudCanje;

  SolicitudCanje({
    required this.idVentaIntermediada,
    required this.idTecnico,
    required this.recompensas,
    required this.puntosCanjeados_SolicitudCanje,
  });

  factory SolicitudCanje.fromJson(Map<String, dynamic> json) =>
      _$SolicitudCanjeFromJson(json);

  Map<String, dynamic> toJson() => _$SolicitudCanjeToJson(this);
}
