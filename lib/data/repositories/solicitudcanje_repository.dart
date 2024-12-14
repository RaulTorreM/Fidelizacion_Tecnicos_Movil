import 'dart:convert';

import '../../services/api_service.dart';
import '../models/solicitud_canje.dart';
import '../models/solicitud_canje_detalle.dart';
import '../models/solicitud_canje_resumen.dart';


class SolicitudCanjeRepository {
  final ApiService apiService;

  SolicitudCanjeRepository({required this.apiService});

  Future<void> guardarSolicitudCanje(SolicitudCanje solicitudCanje) async {
    try {
      await apiService.guardarSolicitudCanje(solicitudCanje.toJson());
    } catch (e) {
      throw Exception('Error al guardar la solicitud de canje: $e');
    }
  }

  Future<List<SolicitudCanjeResumen>> obtenerSolicitudesCanjeResumen(String idTecnico) async {
    try {
      final solicitudes = await apiService.obtenerSolicitudesCanje(idTecnico);

      return solicitudes;
    } catch (e) {

      throw Exception('Error al obtener las solicitudes de canje: $e');
    }
  }

  Future<SolicitudCanjeDetalles> obtenerSolicitudCanjeDetalles(String idSolicitud) async {
    try {
      final detalles = await apiService.obtenerSolicitudCanjeDetalles(idSolicitud);

      return detalles;
    } catch (e) {
      throw Exception('Error al obtener los detalles de la solicitud de canje: $e');
    }
  }

}

