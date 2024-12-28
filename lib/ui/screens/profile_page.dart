import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/tecnico.dart';
import '../../logic/profile_bloc.dart';
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
  final Color color1 = const Color.fromARGB(255, 60, 78, 129);
  final Color color2 = const Color.fromARGB(255, 35, 53, 95);
  final Color color3 = const Color.fromARGB(255, 42, 93, 175);
  final Color color4 = const Color.fromARGB(255, 86, 147, 221);

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
        centerTitle: true,
        backgroundColor: color1,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color2, color4],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Consumer<ProfileBloc>(
          builder: (context, bloc, child) {
            if (bloc.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (bloc.error != null) {
              return Center(
                child: Text(
                  'Error: ${bloc.error}',
                  style: TextStyle(color: color4, fontSize: 18),
                ),
              );
            }

            final tecnico = bloc.tecnico;

            if (tecnico == null) {
              return Center(
                child: Text(
                  'No se encontraron datos.',
                  style: TextStyle(color: color4, fontSize: 18),
                ),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    child: Text(
                      tecnico.nombreTecnico[0],
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: color1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    tecnico.nombreTecnico,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: color4,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildInfoCard('ID Técnico', tecnico.idTecnico),
                  _buildInfoCard('Celular', tecnico.celularTecnico),
                  _buildInfoCard('Rango', tecnico.rangoTecnico ?? 'Sin rango'),
                  _buildInfoCard('Puntos Totales', '${tecnico.totalPuntosActualesTecnico}'),
                  _buildInfoCard(
                      'Fecha de Nacimiento', tecnico.fechaNacimientoTecnico ?? 'No disponible'),
                  _buildInfoCard('Histórico de Puntos', '${tecnico.historicoPuntosTecnico}'),
                  _buildOficiosCard(tecnico.oficios, context),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
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
                      foregroundColor: Colors.white, backgroundColor: color4,
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color1,
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 2,
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOficiosCard(List<Oficio> oficios, BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Oficios',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color1,
              ),
            ),
            const Divider(),
            ...oficios.map((oficio) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.work, color: color1),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            oficio.nombreOficio,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            oficio.descripcion_Oficio,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
