import 'package:json_annotation/json_annotation.dart';
import 'recompensa_detalle.dart'; // Asegúrate de importar el nuevo modelo

part 'solicitud_canje_detalle.g.dart';

@JsonSerializable()
class SolicitudCanjeDetalle {
  final String idSolicitudCanje;
  final String idVentaIntermediada;
  final String fechaHoraEmisionVentaIntermediada;
  final String idTecnico;
  final String? idUser; // Puede ser null
  final String fechaHoraSolicitudCanje;
  final int diasTranscurridosSolicitudCanje;
  final int puntosComprobanteSolicitudCanje;
  final int puntosCanjeadosSolicitudCanje;
  final int puntosRestantesSolicitudCanje;
  final String? comentarioSolicitudCanje; // Puede ser null
  final List<RecompensaDetalle> recompensas; // Cambio aquí

  SolicitudCanjeDetalle({
    required this.idSolicitudCanje,
    required this.idVentaIntermediada,
    required this.fechaHoraEmisionVentaIntermediada,
    required this.idTecnico,
    this.idUser, // Puede ser null
    required this.fechaHoraSolicitudCanje,
    required this.diasTranscurridosSolicitudCanje,
    required this.puntosComprobanteSolicitudCanje,
    required this.puntosCanjeadosSolicitudCanje,
    required this.puntosRestantesSolicitudCanje,
    this.comentarioSolicitudCanje, // Puede ser null
    required this.recompensas, // Cambio aquí
  });

  factory SolicitudCanjeDetalle.fromJson(Map<String, dynamic> json) {
    return _$SolicitudCanjeDetalleFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SolicitudCanjeDetalleToJson(this);
}
