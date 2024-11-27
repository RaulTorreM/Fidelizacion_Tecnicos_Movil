import 'package:flutter/material.dart';
import '../../data/models/solicitud_canje.dart'; // Asegúrate de tener tu modelo de SolicitudCanje

class SolicitudCanjeDetallesPage extends StatelessWidget {
  final SolicitudCanje solicitudCanje; // Solicitud de canje que recibimos

  SolicitudCanjeDetallesPage({required this.solicitudCanje});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la Solicitud de Canje'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ID de Venta Intermediada: ${solicitudCanje.idVentaIntermediada}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 10),
            Text('Puntos Canjeados: ${solicitudCanje.puntosCanjeados_SolicitudCanje}'),
            SizedBox(height: 10),
            Text('Recompensas Solicitadas:'),
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: Icon(Icons.card_giftcard, color: Colors.green),
                    subtitle: Text(
                      'Cantidad: ',
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aquí podrías agregar más lógica, como actualizar el estado o volver a la página anterior
                Navigator.pop(context); // Regresar a la lista de solicitudes
              },
              child: Text('Regresar'),
            ),
          ],
        ),
      ),
    );
  }
}
