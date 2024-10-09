import 'package:json_annotation/json_annotation.dart';

part 'venta_intermediada.g.dart'; // Asegúrate de que esta línea esté presente

@JsonSerializable()
class VentaIntermediada {
  String idVentaIntermediada;
  String idTecnico;
  String nombreCliente;
  String tipoCodigoCliente;
  String codigoCliente;
  DateTime fechaHoraEmision;
  DateTime fechaHoraCargada;
  double montoTotal;
  int puntosGanados;
  String estado;

  VentaIntermediada({
    required this.idVentaIntermediada,
    required this.idTecnico,
    required this.nombreCliente,
    required this.tipoCodigoCliente,
    required this.codigoCliente,
    required this.fechaHoraEmision,
    required this.fechaHoraCargada,
    required this.montoTotal,
    required this.puntosGanados,
    required this.estado,
  });

  factory VentaIntermediada.fromJson(Map<String, dynamic> json) {
    return VentaIntermediada(
      idVentaIntermediada: json['idVentaIntermediada'] as String? ?? '',
      idTecnico: json['idTecnico'] as String? ?? '',
      nombreCliente: json['nombreCliente_VentaIntermediada'] as String? ?? 'Sin nombre',
      tipoCodigoCliente: json['tipoCodigoCliente_VentaIntermediada'] as String? ?? '',
      codigoCliente: json['codigoCliente_VentaIntermediada'] as String? ?? '',
      fechaHoraEmision: DateTime.parse(json['fechaHoraEmision_VentaIntermediada'] as String),
      fechaHoraCargada: DateTime.parse(json['fechaHoraCargada_VentaIntermediada'] as String),
      montoTotal: (json['montoTotal_VentaIntermediada'] as num?)?.toDouble() ?? 0.0,
      puntosGanados: json['puntosGanados_VentaIntermediada'] as int? ?? 0,
      estado: json['estadoVentaIntermediada'] as String? ?? 'Desconocido',
    );
  }
}