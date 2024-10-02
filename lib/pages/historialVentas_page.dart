import 'package:flutter/material.dart';
import '../api_connection/api_service.dart'; // Asegúrate de importar tu servicio API

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

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Permitir desplazamiento horizontal
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Número de Comprobante')),
                DataColumn(label: Text('Fecha y Hora de Emisión')),
                DataColumn(label: Text('Fecha y Hora Cargada')),
                DataColumn(label: Text('Cliente')),
                DataColumn(label: Text('Monto Total')),
                DataColumn(label: Text('Puntos Generados')),
                DataColumn(label: Text('Estado')),
              ],
              rows: ventas.map((venta) {
                return DataRow(cells: [
                  DataCell(Text(venta.idVentaIntermediada)),
                  DataCell(Text(venta.fechaHoraEmision.toString())),
                  DataCell(Text(venta.fechaHoraCargada.toString())),
                  DataCell(Text(venta.nombreCliente)),
                  DataCell(Text('\$${venta.montoTotal}')),
                  DataCell(Text('${venta.puntosGanados}')),
                  DataCell(Text(venta.estado)),
                ]);
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
