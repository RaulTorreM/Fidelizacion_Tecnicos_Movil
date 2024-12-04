import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../logic/recompensa_bloc.dart';
import '../../data/models/recompensa.dart';

class RecompensasPage extends StatefulWidget {
  const RecompensasPage({Key? key}) : super(key: key);

  @override
  State<RecompensasPage> createState() => _RecompensasPageState();
}

class _RecompensasPageState extends State<RecompensasPage> {
  late Future<void> _future;

  @override
  void initState() {
    super.initState();
    // Inicializar la carga de recompensas
    _future = _cargarRecompensas();
  }

  Future<void> _cargarRecompensas() async {
    final recompensaBloc = Provider.of<RecompensaBloc>(context, listen: false);
    await recompensaBloc.obtenerRecompensas();
  }

  @override
  Widget build(BuildContext context) {
    final recompensaBloc = Provider.of<RecompensaBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recompensas Disponibles'),
      ),
      body: FutureBuilder<void>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (recompensaBloc.errorMessage != null) {
            return Center(child: Text(recompensaBloc.errorMessage!));
          } else {
            return _buildRecompensaList(recompensaBloc.recompensas);
          }
        },
      ),
    );
  }

  Widget _buildRecompensaList(List<Recompensa> recompensas) {
    // Agrupar recompensas por tipo
    final groupedRecompensas = <String, List<Recompensa>>{};
    for (var recompensa in recompensas) {
      groupedRecompensas.putIfAbsent(recompensa.tipoRecompensa, () => []).add(recompensa);
    }

    return ListView(
      padding: const EdgeInsets.all(12.0),
      children: groupedRecompensas.entries.map((entry) {
        final tipoRecompensa = entry.key;
        final listaRecompensas = entry.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _getIconForCategory(tipoRecompensa), // Ícono para la categoría
                const SizedBox(width: 8),
                Text(
                  tipoRecompensa,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF03346E),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Número de columnas
                childAspectRatio: 1.5, // Relación de aspecto de las tarjetas
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: listaRecompensas.length,
              itemBuilder: (context, index) {
                return _buildRecompensaCard(listaRecompensas[index]);
              },
            ),
            const SizedBox(height: 16),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildRecompensaCard(Recompensa recompensa) {
    final stock = recompensa.stock_Recompensa;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: _getBackgroundColorForCategory(recompensa.tipoRecompensa),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Descripción de la recompensa (principal)
            Text(
              recompensa.descripcionRecompensa,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF03346E),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            // Puntos de costo
            Text(
              '${recompensa.costoPuntos_Recompensa} Puntos',
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF555555),
              ),
            ),
            const SizedBox(height: 6),
            // Stock
            Text(
              stock > 0 ? 'Stock: $stock' : 'Sin stock',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: stock > 0 ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getIconForCategory(String category) {
    switch (category) {
      case 'Accesorio':
        return const Icon(Icons.watch, color: Colors.blue);
      case 'EPP':
        return const Icon(Icons.shield, color: Colors.orange);
      case 'Herramienta':
        return const Icon(Icons.build, color: Colors.green);
      default:
        return const Icon(Icons.category, color: Colors.grey);
    }
  }

  Color _getBackgroundColorForCategory(String category) {
    switch (category) {
      case 'Accesorio':
        return const Color(0xFFE3F2FD); // Azul claro
      case 'EPP':
        return const Color(0xFFFFF3E0); // Naranja claro
      case 'Herramienta':
        return const Color(0xFFE8F5E9); // Verde claro
      default:
        return const Color(0xFFF5F5F5); // Gris claro
    }
  }
}
