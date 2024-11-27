import 'dart:async';

import '../data/repositories/solicitudcanje_repository.dart';
import '../data/models/solicitud_canje.dart';

class SolicitudCanjeBloc {
  final SolicitudCanjeRepository solicitudCanjeRepository;

  // Controladores para los estados
  final _stateController = StreamController<SolicitudCanjeState>.broadcast();
  final _solicitudesController = StreamController<List<SolicitudCanje>>.broadcast();

  Stream<SolicitudCanjeState> get state => _stateController.stream;
  Stream<List<SolicitudCanje>> get solicitudesStream => _solicitudesController.stream;

  SolicitudCanjeBloc({required this.solicitudCanjeRepository});

  void guardarSolicitudCanje(SolicitudCanje solicitudCanje) async {
    _stateController.add(SolicitudCanjeLoading());
    try {
      await solicitudCanjeRepository.guardarSolicitudCanje(solicitudCanje);
      _stateController.add(SolicitudCanjeSuccess());
    } on Exception catch (e) {
      _stateController.add(SolicitudCanjeFailure('Fallo al guardar: ${e.toString()}'));
    }
  }

  void obtenerSolicitudesCanje(String idTecnico) async {
    _stateController.add(SolicitudCanjeLoading());
    try {
      List<SolicitudCanje> solicitudes = await solicitudCanjeRepository.obtenerSolicitudesCanje(idTecnico);
      _solicitudesController.add(solicitudes);
      _stateController.add(SolicitudCanjeSuccess());
    } on Exception catch (e) {
      _stateController.add(SolicitudCanjeFailure('Fallo al obtener las solicitudes: ${e.toString()}'));
    }
  }

  void obtenerSolicitudCanjeDetalles(String idSolicitud) async {
    _stateController.add(SolicitudCanjeLoading());
    try {
      SolicitudCanje solicitud = await solicitudCanjeRepository.obtenerSolicitudCanjeDetalles(idSolicitud);
      // Aquí podrías hacer algo con los detalles de la solicitud, como enviarlos a la UI.
      _stateController.add(SolicitudCanjeDetallesSuccess(solicitud)); // Emitimos el éxito con los detalles
    } on Exception catch (e) {
      _stateController.add(SolicitudCanjeFailure('Fallo al obtener los detalles: ${e.toString()}'));
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
  final SolicitudCanje solicitudCanje;

  SolicitudCanjeDetallesSuccess(this.solicitudCanje);
}


class SolicitudCanjeFailure extends SolicitudCanjeState {
  final String error;

  SolicitudCanjeFailure(this.error);
}
