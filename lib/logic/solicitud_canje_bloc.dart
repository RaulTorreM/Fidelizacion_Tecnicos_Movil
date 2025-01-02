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
  try {
    _stateController.add(SolicitudCanjeLoading()); // Indica que se está cargando
    final nuevasSolicitudes = await solicitudCanjeRepository.obtenerSolicitudesCanjeResumen(idTecnico);
    _solicitudesController.add(nuevasSolicitudes); // Emite las nuevas solicitudes
  } catch (e) {
    _stateController.add(SolicitudCanjeFailure( e.toString())); // Manejo de errores
  }
}


  void obtenerSolicitudCanjeDetalles(String idSolicitud) async {
    try {
      final detalles = await solicitudCanjeRepository.obtenerSolicitudCanjeDetalles(idSolicitud);
      _stateController.add(SolicitudCanjeDetallesSuccess(detalles));
    } catch (e) {
      _stateController.add(SolicitudCanjeFailure('Error al obtener los detalles: $e'));
    }
  }

  void eliminarSolicitudCanje(String idSolicitudCanje) async {
    _stateController.add(SolicitudCanjeLoading());
    try {
      final resultado = await solicitudCanjeRepository.eliminarSolicitudCanje(idSolicitudCanje);
      if (resultado) {
        _stateController.add(SolicitudCanjeEliminadaSuccess());
        obtenerSolicitudesCanje(''); // Actualizar lista tras eliminar
      } else {
        _stateController.add(SolicitudCanjeFailure('No se pudo eliminar la solicitud.'));
      }
    } catch (e) {
      _stateController.add(SolicitudCanjeFailure('Error al eliminar la solicitud: $e'));
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
  final SolicitudCanjeDetalles detalles;

  SolicitudCanjeDetallesSuccess(this.detalles);
}

class SolicitudCanjeEliminadaSuccess extends SolicitudCanjeState {}

class SolicitudCanjeFailure extends SolicitudCanjeState {
  final String error;

  SolicitudCanjeFailure(this.error);
}
