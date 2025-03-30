import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/repositories/notification_repository.dart';
import '../../services/api_service.dart';
import '../data/models/notification_venta.dart';  // Asegúrate de que el modelo Tecnico esté bien importado

class NotificationBloc extends ChangeNotifier {
  final NotificationRepository _repository;
  List<TecnicoNotification> _notifications = [];
  String? _error;

  NotificationBloc(this._repository);

  List<TecnicoNotification> get notifications => _notifications;
  String? get error => _error;

  Future<void> loadNotifications(String idTecnico) async {
    try {
      // print('Cargando notificaciones para técnico: $idTecnico');
      _notifications = await _repository.getNotifications(idTecnico);
      // print('Notificaciones cargadas: ${_notifications.length}');
      _error = null;
    } catch (e, stackTrace) {
      _error = 'Error al cargar notificaciones: $e';
      _notifications = [];
      print('Error en bloc: $e');
      print('Stack trace: $stackTrace');
    }
    notifyListeners();
  }
}