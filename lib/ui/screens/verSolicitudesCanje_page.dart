import 'package:flutter/material.dart';
import '../../data/models/solicitud_canje.dart';
import '../../data/repositories/solicitudcanje_repository.dart';
import '../../services/api_service.dart';
import 'solicitudCanjeDetalles_page.dart';
import '../../logic/solicitud_canje_bloc.dart'; // Importa el Bloc

class VerSolicitudesCanjePage extends StatefulWidget {
  final String idTecnico; // ID del técnico para filtrar las solicitudes

  VerSolicitudesCanjePage({required this.idTecnico});

  @override
  _VerSolicitudesCanjePageState createState() => _VerSolicitudesCanjePageState();
}

class _VerSolicitudesCanjePageState extends State<VerSolicitudesCanjePage> {
  late SolicitudCanjeBloc solicitudCanjeBloc; // Instancia del Bloc
  List<SolicitudCanje> solicitudes = []; // Lista de solicitudes

  @override
  void initState() {
    super.initState();
    solicitudCanjeBloc = SolicitudCanjeBloc(
      solicitudCanjeRepository: SolicitudCanjeRepository(apiService: ApiService.create()),
    );
    solicitudCanjeBloc.obtenerSolicitudesCanje(widget.idTecnico); // Llama al método para obtener solicitudes
  }

  @override
  void dispose() {
    solicitudCanjeBloc.dispose(); // Libera recursos
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Solicitudes de Canje')),
      body: StreamBuilder<SolicitudCanjeState>(
        stream: solicitudCanjeBloc.state,
        builder: (context, snapshot) {
          // Verifica los diferentes estados
          if (snapshot.connectionState == ConnectionState.waiting || snapshot.data is SolicitudCanjeLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data is SolicitudCanjeFailure) {
            final errorState = snapshot.data as SolicitudCanjeFailure;
            return Center(child: Text('Error: ${errorState.error}'));
          }

          if (snapshot.data is SolicitudCanjeSuccess) {
            return StreamBuilder<List<SolicitudCanje>>(
              stream: solicitudCanjeBloc.solicitudesStream,
              builder: (context, solicitudesSnapshot) {
                if (solicitudesSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (solicitudesSnapshot.hasError) {
                  return Center(child: Text('Error al cargar las solicitudes.'));
                }

                solicitudes = solicitudesSnapshot.data ?? [];

                if (solicitudes.isEmpty) {
                  return Center(child: Text('No hay solicitudes disponibles.'));
                }

                return ListView.builder(
                  itemCount: solicitudes.length,
                  itemBuilder: (context, index) {
                    final solicitud = solicitudes[index];
                    return Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        leading: Icon(Icons.card_giftcard, color: Colors.blue),
                        title: Text('Solicitud: ${solicitud.idVentaIntermediada}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Estado: ${solicitudes[index].nombre_EstadoSolicitudCanje ?? "Desconocido"}'),
                            Text('Fecha: ${solicitudes[index].fechaHora_SolicitudCanje ?? "No disponible"}'),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SolicitudCanjeDetallesPage(
                                solicitudCanje: solicitud,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            );
          }

          return Center(child: Text('No hay solicitudes de canje disponibles.'));
        },
      ),
    );
  }
}
