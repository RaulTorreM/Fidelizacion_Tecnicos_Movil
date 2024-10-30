import 'package:json_annotation/json_annotation.dart';

part 'venta_intermediada.g.dart';

@JsonSerializable()
class VentaIntermediada {
  final String idVentaIntermediada;
  final String idTecnico;
  final String nombreTecnico;
  final String tipoCodigoCliente_VentaIntermediada;
  final String codigoCliente_VentaIntermediada;
  final String nombreCliente_VentaIntermediada;
  final String fechaHoraEmision_VentaIntermediada;
  final String fechaHoraCargada_VentaIntermediada;
  final double montoTotal_VentaIntermediada;
  final int puntosGanados_VentaIntermediada;
  final int puntosActuales_VentaIntermediada;
  final int idEstadoVenta;
  final String? estado_nombre; 
  final String? created_at;
  final String? updated_at;
  final String? deleted_at;

  VentaIntermediada({
    required this.idVentaIntermediada,
    required this.idTecnico,
    required this.nombreTecnico,
    required this.tipoCodigoCliente_VentaIntermediada,
    required this.codigoCliente_VentaIntermediada,
    required this.nombreCliente_VentaIntermediada,
    required this.fechaHoraEmision_VentaIntermediada,
    required this.fechaHoraCargada_VentaIntermediada,
    required this.montoTotal_VentaIntermediada,
    required this.puntosGanados_VentaIntermediada,
    required this.puntosActuales_VentaIntermediada,
    required this.idEstadoVenta,
    this.estado_nombre, 
    this.created_at,
    this.updated_at,
    this.deleted_at,
  });

  factory VentaIntermediada.fromJson(Map<String, dynamic> json) => _$VentaIntermediadaFromJson(json);

  Map<String, dynamic> toJson() => _$VentaIntermediadaToJson(this);
}
