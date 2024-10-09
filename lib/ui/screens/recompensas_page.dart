import 'package:flutter/material.dart';
import '../../services/api_service.dart'; // Asegúrate de importar tu servicio API
import '../../data/models/recompensa.dart';

class RecompensasPage extends StatefulWidget {
  const RecompensasPage({Key? key}) : super(key: key);

  @override
  _RecompensasPageState createState() => _RecompensasPageState();
}

class _RecompensasPageState extends State<RecompensasPage> {
  late Future<List<Recompensa>> _recompensas;
  final ApiService _apiService = ApiService.create();

  @override
  void initState() {
    super.initState();
    _recompensas = _fetchRecompensas();
  }

  Future<List<Recompensa>> _fetchRecompensas() async {
    return await _apiService.obtenerRecompensas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recompensas Disponibles'),
      ),
      body: FutureBuilder<List<Recompensa>>(
        future: _recompensas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay recompensas disponibles.'));
          }

          final recompensas = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Número de columnas
                childAspectRatio: 0.75, // Relación de aspecto para las tarjetas
                crossAxisSpacing: 16.0, // Espacio horizontal entre las tarjetas
                mainAxisSpacing: 16.0, // Espacio vertical entre las tarjetas
              ),
              itemCount: recompensas.length,
              itemBuilder: (context, index) {
                return _buildRecompensaCard(recompensas[index]);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecompensaCard(Recompensa recompensa) {
    return Card(
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
              recompensa.tipoRecompensa,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF03346E),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              recompensa.descripcionRecompensa,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF021526),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              '${recompensa.costoPuntosRecompensa} Puntos',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF03346E),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
