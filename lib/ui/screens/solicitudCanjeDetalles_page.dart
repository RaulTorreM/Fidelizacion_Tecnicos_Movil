import 'package:flutter/material.dart';
import '../../data/models/solicitud_canje_detalle.dart';
import '../../services/api_service.dart';
import '../../logic/solicitud_canje_bloc.dart';
import '../../data/repositories/solicitudcanje_repository.dart';

class SolicitudCanjeDetallesPage extends StatefulWidget {
  final String idSolicitud;

  SolicitudCanjeDetallesPage({required this.idSolicitud});

  @override
  _SolicitudCanjeDetallesPageState createState() =>
      _SolicitudCanjeDetallesPageState();
}

class _SolicitudCanjeDetallesPageState extends State<SolicitudCanjeDetallesPage> {
  late SolicitudCanjeBloc solicitudCanjeBloc;

  @override
  void initState() {
    super.initState();
    solicitudCanjeBloc = SolicitudCanjeBloc(
    solicitudCanjeRepository: SolicitudCanjeRepository(
      apiService: DioInstance().getApiService(), // Aquí usamos la instancia compartida
      ),
    );
    solicitudCanjeBloc.obtenerSolicitudCanjeDetalles(widget.idSolicitud);
  }

  @override
  void dispose() {
    solicitudCanjeBloc.dispose();
    super.dispose();
  }
  String obtenerNumeroSolicitud(String idSolicitudCanje) {
    // Divide la cadena por el guion "-" y toma la última parte
    return idSolicitudCanje.split('-').last;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalles de Canje')),
      body: StreamBuilder<SolicitudCanjeState>(
        stream: solicitudCanjeBloc.state,
        builder: (context, snapshot) {
          if (snapshot.data is SolicitudCanjeLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data is SolicitudCanjeFailure) {
            final errorState = snapshot.data as SolicitudCanjeFailure;
            return Center(child: Text('Error: ${errorState.error}'));
          }

          if (snapshot.data is SolicitudCanjeDetallesSuccess) {
            final detalles =
                (snapshot.data as SolicitudCanjeDetallesSuccess).detalles;

            return Column(
              children: [
                
                const SizedBox(height: 8),
                Card(
                  color: const Color.fromARGB(255, 5, 59, 110),
                  margin: EdgeInsets.zero,
                  child: ListTile(
                    leading: Icon(Icons.star, color: const Color.fromARGB(255, 235, 235, 235)),
                    title: Text(
                      'Puntos Totales de la Venta : '+detalles.puntosComprobante_SolicitudCanje.toString(),
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ),
                SizedBox(height: 4),
                _buildEstadoCard(detalles),
                SizedBox(height: 4),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildMainCard(detalles),
                          SizedBox(height: 16),
                          _buildRecompensasTable(detalles),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return Center(child: Text('No se encontraron detalles.'));
        },
      ),
    );
  }

  Widget _buildEstadoCard(SolicitudCanjeDetalles detalles) {
    Color color;
    IconData icon;
    switch (detalles.nombre_EstadoSolicitudCanje) {
      case 'Aprobado':
        color = const Color.fromARGB(167, 3, 201, 10);
        icon = Icons.check_circle_outline;
        break;
      case 'Rechazado':
        color = const Color.fromARGB(167, 99, 29, 24);
        icon = Icons.cancel_outlined;
        break;
      default:
        color = const Color.fromARGB(255, 82, 77, 77);
        icon = Icons.hourglass_empty_outlined;
    }

    return Card(
      color: color.withOpacity(0.2),
      margin: EdgeInsets.zero,
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(
          detalles.nombre_EstadoSolicitudCanje,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: color),
        ),
        subtitle: Text(
          'Días transcurridos de la venta: ${detalles.diasTranscurridos_SolicitudCanje}',
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
        
      ),
    );
  }

  Widget _buildMainCard(SolicitudCanjeDetalles detalles) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(Icons.receipt,'Solicitud N°', obtenerNumeroSolicitud(detalles.idSolicitudCanje)),
            _buildDetailRow(Icons.shopping_cart,'Venta N°', obtenerNumeroSolicitud(detalles.idVentaIntermediada) ),
            _buildDetailRow(Icons.calendar_today,'Fecha de Emisión',
                detalles.fechaHoraEmision_VentaIntermediada),
            _buildDetailRow(Icons.person,'Técnico', detalles.idTecnico),
            _buildDetailRow(Icons.star_outline_sharp,
                'Puntos Canjeados', '${detalles.puntosCanjeados_SolicitudCanje}'),
            _buildDetailRow(Icons.star_half_outlined,'Puntos Restantes',
                '${detalles.puntosRestantes_SolicitudCanje}'),
            _buildDetailRow(Icons.info,
                'Estado', detalles.nombre_EstadoSolicitudCanje),
            if (detalles.comentario_SolicitudCanje != null)
              _buildDetailRow(Icons.comment,
                  'Comentario', detalles.comentario_SolicitudCanje ?? ''),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon ,String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue, size: 28),
          SizedBox(width: 12),
          Text(
            '$label:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecompensasTable(SolicitudCanjeDetalles detalles) {
    final totalMonto = detalles.recompensas.fold<double>(
      0,
      (sum, recompensa) => sum + (recompensa.cantidad * recompensa.costoRecompensa),
    );

    return Table(
      border: TableBorder.all(color: Colors.grey),
      columnWidths: {
        0: FlexColumnWidth(2), // Más espacio para la columna de nombre
        1: FixedColumnWidth(60),
        2: FixedColumnWidth(60),
        3: FixedColumnWidth(80),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.blue[100]),
          children: [
            _buildTableHeader('Nombre'),
            _buildTableHeader('Cant.'),
            _buildTableHeader('Costo'),
            _buildTableHeader('Monto'),
          ],
        ),
        ...detalles.recompensas.map((recompensa) {
          final monto = recompensa.cantidad * recompensa.costoRecompensa;
          return TableRow(
            children: [
              _buildTableCell(recompensa.nombreRecompensa),
              _buildTableCell('${recompensa.cantidad}'),
              _buildTableCell('${recompensa.costoRecompensa}'),
              _buildTableCell('$monto'),
            ],
          );
        }).toList(),
        TableRow(
          decoration: BoxDecoration(color: Colors.grey[300]),
          children: [
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Total:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ),
            TableCell(child: SizedBox.shrink()),
            TableCell(child: SizedBox.shrink()),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$totalMonto',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildTableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }
}
