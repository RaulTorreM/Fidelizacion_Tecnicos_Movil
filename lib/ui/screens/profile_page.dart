import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/tecnico.dart';
import '../../logic/profile_bloc.dart';
import 'cambioOficio_page.dart';
import 'cambioContraseña_page.dart';

class ProfilePage extends StatefulWidget {
  final String idTecnico;

  const ProfilePage({
    Key? key,
    required this.idTecnico,
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final profileBloc = Provider.of<ProfileBloc>(context, listen: false);
      profileBloc.fetchPerfil(widget.idTecnico);
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileBloc = Provider.of<ProfileBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil del Técnico'),
      ),
      body: Consumer<ProfileBloc>(
        builder: (context, bloc, child) {
          if (bloc.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (bloc.error != null) {
            return Center(child: Text('Error: ${bloc.error}'));
          }

          final tecnico = bloc.tecnico;

          if (tecnico == null) {
            return const Center(child: Text('No se encontraron datos.'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    '${tecnico.nombreTecnico}',
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                _buildInfoCard('ID Técnico', tecnico.idTecnico),
                _buildInfoCard('Celular', tecnico.celularTecnico),
                _buildInfoCard('Rango', tecnico.rangoTecnico ?? 'Sin rango'),
                _buildInfoCard('Puntos Totales', '${tecnico.totalPuntosActualesTecnico}'),
                _buildInfoCard('Fecha de Nacimiento', tecnico.fechaNacimientoTecnico ?? 'No disponible'),
                _buildInfoCard('Histórico de Puntos', '${tecnico.historicoPuntosTecnico}'),
                _buildOficiosCard(tecnico.oficios, tecnico, context),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangePasswordPage(idTecnico: tecnico.idTecnico),
                        ),
                      );
                    },
                    icon: const Icon(Icons.lock_outline),
                    label: const Text('Actualizar Contraseña'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Expanded(
              child: Text(
                value,
                textAlign: TextAlign.end,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOficiosCard(List<Oficio> oficios, Tecnico tecnico, BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: const Text(
          'Oficios',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: oficios.map((oficio) => Text(oficio.nombreOficio)).toList(),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeJobPage(tecnico: tecnico),
              ),
            );
          },
        ),
      ),
    );
  }
}
