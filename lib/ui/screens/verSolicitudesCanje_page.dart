import 'package:flutter/material.dart';
import '../../data/models/solicitud_canje_resumen.dart';
import '../../data/repositories/solicitudcanje_repository.dart';
import '../../services/api_service.dart';
import 'solicitudCanjeDetalles_page.dart';
import '../../logic/solicitud_canje_bloc.dart'; // Importa el Bloc

class VerSolicitudesCanjePage extends StatefulWidget {
  final String idTecnico; // ID del técnico para filtrar las solicitudes

  VerSolicitudesCanjePage({required this.idTecnico});

  @override
  _VerSolicitudesCanjePageState createState() =>
      _VerSolicitudesCanjePageState();
}

class _VerSolicitudesCanjePageState extends State<VerSolicitudesCanjePage> {
  late SolicitudCanjeBloc solicitudCanjeBloc;

  @override
  void initState() {
    super.initState();
    solicitudCanjeBloc = SolicitudCanjeBloc(
      solicitudCanjeRepository: SolicitudCanjeRepository(apiService: ApiService.create()),
    );
    solicitudCanjeBloc.obtenerSolicitudesCanje(widget.idTecnico); 
  }

  @override
  void dispose() {
    solicitudCanjeBloc.dispose(); // Libera recursos
    super.dispose();
  }
  String obtenerNumeroSolicitud(String idSolicitudCanje) {
    // Divide la cadena por el guion "-" y toma la última parte
    return idSolicitudCanje.split('-').last;
  }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Solicitudes de Canje')),
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

          return StreamBuilder<List<SolicitudCanjeResumen>>(
            stream: solicitudCanjeBloc.solicitudesStream,
            builder: (context, snapshot) {
              final solicitudes = snapshot.data ?? [];
              if (solicitudes.isEmpty) {
                return Center(child: Text('No hay solicitudes disponibles.'));
              }

              return ListView.builder(
                itemCount: solicitudes.length,
                itemBuilder: (context, index) {
                  final solicitud = solicitudes[index];
                  return _buildSolicitudCard(solicitud);
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildSolicitudCard(SolicitudCanjeResumen solicitud) {
    final color = _getCardColor(solicitud.nombre_EstadoSolicitudCanje);
    final icon = _getCardIcon(solicitud.nombre_EstadoSolicitudCanje);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: color.withOpacity(0.2),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(
          'Solicitud: N° ${obtenerNumeroSolicitud(solicitud.idSolicitudCanje)}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              solicitud.nombre_EstadoSolicitudCanje ?? 'Desconocido',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                SizedBox(width: 4),
                Text(
                  solicitud.fechaHora_SolicitudCanje ?? 'No disponible',
                  style: TextStyle(fontSize: 14, color: const Color.fromARGB(255, 0, 0, 0)),
                ),
              ],
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SolicitudCanjeDetallesPage(
                idSolicitud: solicitud.idSolicitudCanje,
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getCardColor(String? estado) {
    switch (estado) {
      case 'Aprobado':
        return Color.fromARGB(167, 66, 167, 69);
      case 'Rechazado':
        return Color.fromARGB(167, 99, 29, 24);
      default:
        return Color.fromARGB(255, 82, 77, 77);
    }
  }

  IconData _getCardIcon(String? estado) {
    switch (estado) {
      case 'Aprobado':
        return Icons.check_circle_outline;
      case 'Rechazado':
        return Icons.cancel_outlined;
      default:
        return Icons.hourglass_empty_outlined;
    }
  }
}
