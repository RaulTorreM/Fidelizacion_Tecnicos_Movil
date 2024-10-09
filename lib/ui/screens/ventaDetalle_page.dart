import 'package:flutter/material.dart';
import '../../data/models/venta_intermediada.dart';

class VentaDetallePage extends StatelessWidget {
  final VentaIntermediada venta;

  const VentaDetallePage({Key? key, required this.venta}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la Venta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título
              Text(
                'Número de Comprobante: ${venta.idVentaIntermediada}',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Información de la Venta
              _buildInfoCard('Cliente', venta.nombreCliente),
              _buildInfoCard('Fecha y Hora de Emisión', venta.fechaHoraEmision.toString()),
              _buildInfoCard('Fecha y Hora Cargada', venta.fechaHoraCargada.toString()),
              _buildInfoCard('Monto Total', '\$${venta.montoTotal}'),
              _buildInfoCard('Puntos Generados', '${venta.puntosGanados}'),
              _buildInfoCard('Estado', venta.estado),

              const SizedBox(height: 20),
            ],
          ),
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
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            Text(
              value,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
