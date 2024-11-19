import 'dart:async';

import '../data/repositories/solicitudcanje_repository.dart';
import '../data/models/solicitud_canje.dart';

class SolicitudCanjeBloc {
  final SolicitudCanjeRepository solicitudCanjeRepository;

  // Controladores para los estados
  final _stateController = StreamController<SolicitudCanjeState>.broadcast();

  Stream<SolicitudCanjeState> get state => _stateController.stream;

  SolicitudCanjeBloc({required this.solicitudCanjeRepository});

  void guardarSolicitudCanje(SolicitudCanje solicitudCanje) async {
    _stateController.add(SolicitudCanjeLoading());
    try {
      await solicitudCanjeRepository.guardarSolicitudCanje(solicitudCanje);
      _stateController.add(SolicitudCanjeSuccess());
    } catch (e) {
      _stateController.add(SolicitudCanjeFailure(e.toString()));
    }
  }

  void dispose() {
    _stateController.close();
  }
}

// Estados del Bloc
abstract class SolicitudCanjeState {}

class SolicitudCanjeInitial extends SolicitudCanjeState {}

class SolicitudCanjeLoading extends SolicitudCanjeState {}

class SolicitudCanjeSuccess extends SolicitudCanjeState {}

class SolicitudCanjeFailure extends SolicitudCanjeState {
  final String error;

  SolicitudCanjeFailure(this.error);
}
