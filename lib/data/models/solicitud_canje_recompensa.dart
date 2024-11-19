import 'package:json_annotation/json_annotation.dart';

part 'solicitud_canje_recompensa.g.dart';

@JsonSerializable()
class SolicitudCanjeRecompensa {
  final String idRecompensa;
  final int cantidad;
  final double costoRecompensa;

  SolicitudCanjeRecompensa({
    required this.idRecompensa,
    required this.cantidad,
    required this.costoRecompensa,
  });

  factory SolicitudCanjeRecompensa.fromJson(Map<String, dynamic> json) =>
      _$SolicitudCanjeRecompensaFromJson(json);

  Map<String, dynamic> toJson() => _$SolicitudCanjeRecompensaToJson(this);
}
