import 'package:flutter/material.dart';
import '../../services/api_service.dart'; // Asegúrate de importar tu servicio API
import '../../data/models/venta_intermediada.dart';
import '../screens/ventaDetalle_page.dart'; // Asegúrate de crear una página para mostrar detalles de la venta

class HistorialVentasPage extends StatefulWidget {
  final String idTecnico;

  const HistorialVentasPage({Key? key, required this.idTecnico}) : super(key: key);

  @override
  _HistorialVentasPageState createState() => _HistorialVentasPageState();
}

class _HistorialVentasPageState extends State<HistorialVentasPage> {
  late Future<List<VentaIntermediada>> _ventas;
  final ApiService _apiService = DioInstance().getApiService();

  @override
  void initState() {
    super.initState();
    _ventas = _fetchVentas();
  }

  Future<List<VentaIntermediada>> _fetchVentas() async {
    try {
      return await _apiService.getVentasIntermediadas(widget.idTecnico);
    } catch (e) {
      // Manejo de errores específicos
      rethrow;
    }
  }

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
        title: const Text('Historial de Ventas Intermediadas'),
      ),
      body: FutureBuilder<List<VentaIntermediada>>(
        future: _ventas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Muestra un indicador de carga mientras los datos se están cargando
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Manejo de errores
            final error = snapshot.error.toString();
            if (error.contains("404")) {
              return const Center(
                child: Text(
                  'Aún no tienes ventas intermediadas registradas.\nAquí aparecerán tus próximas ventas vinculadas.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              );
            } else {
              return Center(
                child: Text(
                  'Ocurrió un error: $error',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.red),
                ),
              );
            }
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Cuando no hay ventas intermediadas registradas
            return const Center(
              child: Text(
                'Aún no tienes ventas intermediadas registradas.\nAquí aparecerán tus próximas ventas vinculadas.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            );
          }

          final ventas = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 1.2,
              ),
              itemCount: ventas.length,
              itemBuilder: (context, index) {
                final venta = ventas[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VentaDetallePage(venta: venta),
                      ),
                    );
                  },
                  child: Card(
                    color: const Color.fromARGB(118, 16, 4, 61),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            venta.idVentaIntermediada,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 233, 239, 240),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Puntos Generados: ${venta.puntosGanados_VentaIntermediada}",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 9, 255, 0),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            venta.fechaHoraEmision_VentaIntermediada,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 213, 223, 231),
                            ),
                          ),
                          Text(
                            venta.estado_nombre!,
                            style: TextStyle(
                              fontSize: 12,
                              color: getColorForEstado(venta.idEstadoVenta),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
