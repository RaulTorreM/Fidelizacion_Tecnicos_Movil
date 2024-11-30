import 'dart:async';
import 'dart:convert';

import '../data/repositories/solicitudcanje_repository.dart';
import '../data/models/solicitud_canje.dart';
import '../data/models/solicitud_canje_resumen.dart';
import '../data/models/solicitud_canje_detalle.dart';

class SolicitudCanjeBloc {
  final SolicitudCanjeRepository solicitudCanjeRepository;

  final _stateController = StreamController<SolicitudCanjeState>.broadcast();
  final _solicitudesController = StreamController<List<SolicitudCanjeResumen>>.broadcast();

  Stream<SolicitudCanjeState> get state => _stateController.stream;
  Stream<List<SolicitudCanjeResumen>> get solicitudesStream => _solicitudesController.stream;

  SolicitudCanjeBloc({required this.solicitudCanjeRepository});

  void guardarSolicitudCanje(SolicitudCanje solicitudCanje) async {
    _stateController.add(SolicitudCanjeLoading());
    try {
      await solicitudCanjeRepository.guardarSolicitudCanje(solicitudCanje);
      _stateController.add(SolicitudCanjeSuccess());
    } catch (e) {
      _stateController.add(SolicitudCanjeFailure('Error al guardar la solicitud: $e'));
    }
  }

  void obtenerSolicitudesCanje(String idTecnico) async {
    _stateController.add(SolicitudCanjeLoading());
    try {
      final solicitudes = await solicitudCanjeRepository.obtenerSolicitudesCanjeResumen(idTecnico);
      _solicitudesController.add(solicitudes);
      _stateController.add(SolicitudCanjeSuccess());
    } catch (e) {
      _stateController.add(SolicitudCanjeFailure('Error al obtener las solicitudes: $e'));
    }
  }

  void obtenerSolicitudCanjeDetalles(String idSolicitud) async {
  try {
    final detalles = await solicitudCanjeRepository.obtenerSolicitudCanjeDetalles(idSolicitud);
    print('Detalles obtenidos: ${json.encode(detalles)}');
    _stateController.add(SolicitudCanjeDetallesSuccess(detalles));
    } catch (e) {
      print('Error al obtener los detalles: $e');
      _stateController.add(SolicitudCanjeFailure('Error al obtener los detalles: $e'));
    }
  }





  void dispose() {
    _stateController.close();
    _solicitudesController.close();
  }
}

// Estados del Bloc
abstract class SolicitudCanjeState {}

class SolicitudCanjeInitial extends SolicitudCanjeState {}

class SolicitudCanjeLoading extends SolicitudCanjeState {}

class SolicitudCanjeSuccess extends SolicitudCanjeState {}


class SolicitudCanjeDetallesSuccess extends SolicitudCanjeState {
  final SolicitudCanjeDetalle detalles;

  SolicitudCanjeDetallesSuccess(this.detalles);

  get solicitudCanje => null;
}



class SolicitudCanjeFailure extends SolicitudCanjeState {
  final String error;

  SolicitudCanjeFailure(this.error);
}
