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
  final ApiService _apiService = ApiService.create(); // Definición de _apiService

  @override
  void initState() {
    super.initState();
    _ventas = _fetchVentas();
  }

  Future<List<VentaIntermediada>> _fetchVentas() async {
    return await _apiService.getVentasIntermediadas(widget.idTecnico);
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
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay ventas registradas.'));
          }

          final ventas = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Número de columnas
                crossAxisSpacing: 16.0, // Espacio horizontal entre tarjetas
                mainAxisSpacing: 16.0, // Espacio vertical entre tarjetas
                childAspectRatio: 1.2, // Ajusta la proporción de las tarjetas
              ),
              itemCount: ventas.length,
              itemBuilder: (context, index) {
                final venta = ventas[index];
                return GestureDetector(
                  onTap: () {
                    // Navega a la página de detalles de la venta
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VentaDetallePage(venta: venta),
                      ),
                    );
                  },
                  child: Card(
                    color: const Color(0xFFE2E2B6),
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
                              color: Color(0xFF03346E),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            venta.nombreCliente,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color.fromARGB(255, 161, 67, 4),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            venta.fechaHoraEmision.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF021526),
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
