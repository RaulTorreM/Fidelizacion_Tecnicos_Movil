import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../data/models/venta_intermediada.dart';
import '../screens/ventaDetalle_page.dart';

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
        backgroundColor: const Color(0xFF234F9D),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2A5DAF), Color(0xFF5693DD)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder<List<VentaIntermediada>>(
          future: _ventas,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              final error = snapshot.error.toString();
              if (error.contains("404")) {
                return const Center(
                  child: Text(
                    'Aún no tienes ventas intermediadas registradas.\nAquí aparecerán tus próximas ventas vinculadas.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 255, 255, 255)),
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
              return const Center(
                child: Text(
                  'Aún no tienes ventas intermediadas registradas.\nAquí aparecerán tus próximas ventas vinculadas.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 255, 255, 255)),
                ),
              );
            }

            final ventas = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 1.0,
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
                      elevation: 10,
                      shadowColor: Colors.grey.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAF3FE), // Color pastel suave
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text(
                                "ID: ${venta.idVentaIntermediada}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF234F9D),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            Text(
                              "Puntos: ${venta.puntosGanados_VentaIntermediada}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              venta.fechaHoraEmision_VentaIntermediada,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black54,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: getColorForEstado(venta.idEstadoVenta).withOpacity(0.1),
                                border: Border.all(
                                  color: getColorForEstado(venta.idEstadoVenta),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                venta.estado_nombre!,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: getColorForEstado(venta.idEstadoVenta),
                                ),
                                textAlign: TextAlign.center,
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
      ),
    );
  }
}
