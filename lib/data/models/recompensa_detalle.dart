import 'package:json_annotation/json_annotation.dart';

part 'recompensa_detalle.g.dart';

@JsonSerializable()
  class RecompensaDetalle {
    final String idRecompensa;
    final int cantidad;
    final int costoRecompensa;
    final String nombreRecompensa;

    RecompensaDetalle({
      required this.idRecompensa,
      required this.cantidad,
      required this.costoRecompensa,
      required this.nombreRecompensa,
    });

      factory RecompensaDetalle.fromJson(Map<String, dynamic> json) =>
      _$RecompensaDetalleFromJson(json);

       Map<String, dynamic> toJson() => _$RecompensaDetalleToJson(this);



}
