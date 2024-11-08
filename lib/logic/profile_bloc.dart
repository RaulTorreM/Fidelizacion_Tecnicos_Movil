import 'package:flutter/material.dart';

class ProfileBloc extends ChangeNotifier {
  final PerfilRepository perfilRepository;
  String? _message;  // Para almacenar mensajes de éxito o error

  ProfileBloc(this.perfilRepository);

  String? get message => _message;

  Future<void> changeJobs(String idTecnico, List<int> oficios, String password) async {
    try {
      // Llamar al repositorio para actualizar los oficios
      final response = await perfilRepository.updateJobs(idTecnico, oficios, password);

      // Manejar la respuesta de éxito
      if (response.containsKey('message') && response['message'] == 'Oficios actualizados correctamente') {
        _message = 'Oficios actualizados correctamente';
      } else {
        _message = 'Error desconocido al actualizar los oficios';
      }
      
      notifyListeners();  // Notificar a la UI que el mensaje ha cambiado
    } catch (e) {
      // Manejo de errores
      _message = 'Error al cambiar oficios: ${e.toString()}';
      notifyListeners();
    }
  }

  // Método para limpiar el mensaje después de mostrarlo
  void clearMessage() {
    _message = null;
    notifyListeners();
  }
}
