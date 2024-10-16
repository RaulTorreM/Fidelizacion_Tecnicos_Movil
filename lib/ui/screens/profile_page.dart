import 'package:flutter/material.dart';
import '../../data/models/tecnico.dart';
import 'cambioContraseña_page.dart'; // Importa la página de cambio de contraseña

class ProfilePage extends StatelessWidget {
  final Tecnico tecnico; // Cambiado para recibir el objeto Tecnico

  const ProfilePage({
    Key? key,
    required this.tecnico,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil del Técnico'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            Center(
              child: Text(
                '${tecnico.nombreTecnico}',
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),

            // Información del Técnico
            _buildInfoCard('ID Técnico', tecnico.idTecnico),
            _buildInfoCard('Celular', tecnico.celularTecnico),
            _buildInfoCard('Rango', tecnico.rangoTecnico!),
            _buildInfoCard('Puntos Totales', '${tecnico.totalPuntosActualesTecnico}'),
            _buildInfoCard('Fecha de Nacimiento', tecnico.fechaNacimientoTecnico!),
            _buildInfoCard('Histórico de Puntos', '${tecnico.historicoPuntosTecnico}'),

            const Spacer(), // Empuja el botón al final de la pantalla

            // Botón "Actualizar Contraseña"
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangePasswordPage(idTecnico: tecnico.idTecnico),
                    ),
                  );
                },
                icon: const Icon(Icons.lock_outline),
                label: const Text('Actualizar Contraseña'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
  
}
