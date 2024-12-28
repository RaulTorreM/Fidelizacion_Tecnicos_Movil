import 'package:flutter/material.dart';
import '../../data/models/venta_intermediada.dart';

class VentaDetallePage extends StatelessWidget {
  final VentaIntermediada venta;

  const VentaDetallePage({Key? key, required this.venta}) : super(key: key);

  Color getColorForEstado(int estado) {
    switch (estado) {
      case 1:
        return const Color(0xFF2394da);
      case 2:
        return const Color(0xFFFF9800);
      case 3:
        return const Color(0xFF4CAF50);
      case 4:
        return const Color(0xFFF44336);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la Venta'),
        backgroundColor: const Color(0xFF234F9D),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2A5DAF), Color(0xFF1E3A68)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título destacado
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Text(
                        'Número de Comprobante: ${venta.idVentaIntermediada}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF234F9D),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Información de la venta
                    _buildInfoCard('Cliente', venta.nombreCliente_VentaIntermediada),
                    _buildInfoCard('Fecha y Hora de Emisión', venta.fechaHoraEmision_VentaIntermediada.toString()),
                    _buildInfoCard('Fecha y Hora Cargada', venta.fechaHoraCargada_VentaIntermediada.toString()),
                    _buildInfoCard('Monto Total', '\$${venta.montoTotal_VentaIntermediada}'),
                    _buildInfoCard('Puntos Generados', '${venta.puntosGanados_VentaIntermediada}'),

                    // Estado con color dinámico
                    _buildEstadoCard('Estado', venta.estado_nombre!, venta.idEstadoVenta),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFFF1F4FB),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(248, 0, 0, 0),
              ),
            ),
            Flexible(
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(220, 0, 0, 0),
                ),
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEstadoCard(String title, String value, int estado) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: getColorForEstado(estado).withOpacity(0.1),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: getColorForEstado(estado).withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: getColorForEstado(estado)),
              ),
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: getColorForEstado(estado),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
