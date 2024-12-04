import 'package:json_annotation/json_annotation.dart';
import 'recompensa_detalle.dart'; // Asegúrate de importar el nuevo modelo

part 'solicitud_canje_detalle.g.dart';

@JsonSerializable()
class SolicitudCanjeDetalles {
  final String idSolicitudCanje;
  final String idVentaIntermediada;
  final String fechaHoraEmision_VentaIntermediada;
  final String idTecnico;
  final String? idUser;
  final String fechaHora_SolicitudCanje;
  final int diasTranscurridos_SolicitudCanje;
  final int puntosComprobante_SolicitudCanje;
  final int puntosCanjeados_SolicitudCanje;
  final int puntosRestantes_SolicitudCanje;
  final String? comentario_SolicitudCanje;
  final String nombre_EstadoSolicitudCanje;
  final List<RecompensaDetalle> recompensas;

  SolicitudCanjeDetalles({
      required this.idSolicitudCanje,
      required this.idVentaIntermediada,
      required this.fechaHoraEmision_VentaIntermediada,
      required this.idTecnico,
      this.idUser,
      required this.fechaHora_SolicitudCanje,
      required this.diasTranscurridos_SolicitudCanje,
      required this.puntosComprobante_SolicitudCanje,
      required this.puntosCanjeados_SolicitudCanje,
      required this.puntosRestantes_SolicitudCanje,
      this.comentario_SolicitudCanje,
      required this.nombre_EstadoSolicitudCanje,
      required this.recompensas,
    });
    factory SolicitudCanjeDetalles.fromJson(Map<String, dynamic> json) =>
      _$SolicitudCanjeDetallesFromJson(json);

       Map<String, dynamic> toJson() => _$SolicitudCanjeDetallesToJson(this);

}
