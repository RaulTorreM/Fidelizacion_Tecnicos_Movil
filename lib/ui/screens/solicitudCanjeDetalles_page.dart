import 'package:flutter/material.dart';
import '../../data/models/solicitud_canje_detalle.dart';
import '../../data/models/solicitud_canje_resumen.dart';
import '../../logic/solicitud_canje_bloc.dart';
import '../../services/api_service.dart';
import '../../data/repositories/solicitudcanje_repository.dart';

class SolicitudCanjeDetallesPage extends StatefulWidget {
  final String idSolicitud;

  SolicitudCanjeDetallesPage({required this.idSolicitud});

  @override
  _SolicitudCanjeDetallesPageState createState() =>
      _SolicitudCanjeDetallesPageState();
}

class _SolicitudCanjeDetallesPageState extends State<SolicitudCanjeDetallesPage> {
  late SolicitudCanjeBloc _solicitudCanjeBloc;

  @override
  void initState() {
    super.initState();
    // Inicializa el Bloc
    _solicitudCanjeBloc = SolicitudCanjeBloc(
      solicitudCanjeRepository: SolicitudCanjeRepository(apiService: ApiService.create()),
    );
    // Obtén los detalles de la solicitud al cargar la página
    _solicitudCanjeBloc.obtenerSolicitudCanjeDetalles(widget.idSolicitud);
  }

  @override
  void dispose() {
    super.dispose();
    _solicitudCanjeBloc.dispose(); // Cierra el Bloc cuando la página se elimine
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la Solicitud de Canje'),
      ),
      body: StreamBuilder<SolicitudCanjeState>(
        stream: _solicitudCanjeBloc.state,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Indicador de carga
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error al cargar los detalles: ${snapshot.error}',
                style: TextStyle(color: Colors.red),
              ),
            );
          } else if (snapshot.hasData) {
            // Verifica que el estado sea de éxito con detalles
            if (snapshot.data is SolicitudCanjeDetallesSuccess) {
              final solicitudCanjeDetalle =
                  (snapshot.data as SolicitudCanjeDetallesSuccess).solicitudCanje;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Mostrar los detalles de la solicitud
                      Text(
                        'ID de Venta Intermediada: ${solicitudCanjeDetalle.idVentaIntermediada}',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Text('ID del Técnico: ${solicitudCanjeDetalle.idTecnico}'),
                      SizedBox(height: 10),
                      if (solicitudCanjeDetalle.nombre_EstadoSolicitudCanje != null)
                        Text('Estado: ${solicitudCanjeDetalle.nombre_EstadoSolicitudCanje}'),
                      SizedBox(height: 10),
                      if (solicitudCanjeDetalle.fechaHora_SolicitudCanje != null)
                        Text('Fecha y Hora: ${solicitudCanjeDetalle.fechaHora_SolicitudCanje}'),
                      SizedBox(height: 10),
                      Text(
                          'Puntos Canjeados: ${solicitudCanjeDetalle.puntosCanjeados_SolicitudCanje}'),
                      SizedBox(height: 20),
                      Text(
                        'Recompensas Solicitadas:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: solicitudCanjeDetalle.recompensas.length,
                        itemBuilder: (context, index) {
                          final recompensa = solicitudCanjeDetalle.recompensas[index];
                          return Card(
                            margin: EdgeInsets.only(bottom: 10),
                            child: ListTile(
                              leading: Icon(Icons.card_giftcard, color: Colors.green),
                              title: Text(recompensa.nombreRecompensa),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Cantidad: ${recompensa.cantidad}'),
                                  Text('Costo en puntos: ${recompensa.costoRecompensa}'),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Regresar a la lista de solicitudes
                        },
                        child: Text('Regresar'),
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.data is SolicitudCanjeFailure) {
              return Center(
                child: Text(
                  'Error al cargar los detalles: ${(snapshot.data as SolicitudCanjeFailure).error}',
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
          }
          return Center(child: Text('No se encontraron detalles para esta solicitud.'));
        },
      ),
    );
  }
}
