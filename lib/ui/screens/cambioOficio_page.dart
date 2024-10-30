import 'package:flutter/material.dart';
import '../../data/models/tecnico.dart';
import '../../data/repositories/perfil_repository.dart';
import '../../services/api_service.dart';
import 'package:dio/dio.dart';
import 'profile_page.dart'; // Importa la página de perfil

class ChangeJobPage extends StatefulWidget {
  final Tecnico tecnico;

  const ChangeJobPage({Key? key, required this.tecnico}) : super(key: key);

  @override
  _ChangeJobPageState createState() => _ChangeJobPageState();
}

class _ChangeJobPageState extends State<ChangeJobPage> {
  String? _selectedJob;
  final _passwordController = TextEditingController();
  final _profileRepository = PerfilRepository(ApiService.create());
  final List<String> jobs = ['Albañil', 'Gasfitero', 'Enchapador'];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedJob = jobs.isNotEmpty ? jobs[0] : null; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cambiar Oficio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Oficio Actual: ${widget.tecnico.oficioTecnico}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedJob,
              decoration: const InputDecoration(
                labelText: 'Nuevo Oficio',
                border: OutlineInputBorder(),
              ),
              onChanged: (newValue) {
                setState(() {
                  _selectedJob = newValue;
                });
              },
              items: jobs.map((job) {
                return DropdownMenuItem(
                  value: job,
                  child: Text(job),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      if (_selectedJob != null && _passwordController.text.isNotEmpty) {
                        setState(() {
                          _isLoading = true;
                        });
                        try {
                          final response = await _profileRepository.changeJob(
                            widget.tecnico.idTecnico,
                            _selectedJob!,
                            _passwordController.text,
                          );

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfilePage(
                                  idTecnico: widget.tecnico.idTecnico,
                                ),
                              ),
                            );

                       
                        } catch (e) {
                          if (e is DioException) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: ${e.response?.statusCode} - ${e.message}')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error de conexión con la API: ${e.toString()}')),
                            );
                          }
                        } finally {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Por favor ingresa todos los datos')),
                        );
                      }
                    },
                    child: const Text('Cambiar Oficio'),
                  ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }
}
