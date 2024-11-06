import 'package:flutter/material.dart';
import '../../data/models/tecnico.dart';  // Importar el modelo Tecnico que contiene Oficio
import '../../data/repositories/perfil_repository.dart';
import '../../services/api_service.dart';
import 'profile_page.dart';

class ChangeJobPage extends StatefulWidget {
  final Tecnico tecnico;

  const ChangeJobPage({Key? key, required this.tecnico}) : super(key: key);

  @override
  _ChangeJobPageState createState() => _ChangeJobPageState();
}

class _ChangeJobPageState extends State<ChangeJobPage> {
  final _passwordController = TextEditingController();
  final _profileRepository = PerfilRepository(ApiService.create());
  List<int> _selectedJobs = [];  // Guardar los IDs de los oficios seleccionados
  List<Oficio> _availableJobs = [];  // Aquí guardamos los oficios disponibles como objetos
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Cargar los oficios disponibles desde la API
    _loadAvailableJobs();
    // Inicializar los oficios seleccionados con los que tiene el técnico (en términos de IDs)
    _selectedJobs = widget.tecnico.oficios.map((e) => e.idOficio).toList();
  }

  // Cargar los oficios disponibles desde la API
  Future<void> _loadAvailableJobs() async {
  try {
    final response = await _profileRepository.getAvailableJobs(); // Aquí esperas List<Oficio>, no List<Tecnico>
    setState(() {
      _availableJobs = response;  // Almacena los oficios disponibles
    });
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error al cargar los oficios: ${e.toString()}')),
    );
  }
}

  // Construir la interfaz para los dropdowns de los oficios
  Widget _buildJobDropdown(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Oficio Actual: ${widget.tecnico.oficios[index].nombreOficio}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: _availableJobs.isNotEmpty
              ? _availableJobs
                  .firstWhere((oficio) => oficio.idOficio == _selectedJobs[index])
                  .nombreOficio
              : null, // Asegúrate de que haya un valor válido
          decoration: const InputDecoration(
            labelText: 'Selecciona un nuevo oficio',
            border: OutlineInputBorder(),
          ),
          onChanged: (newValue) {
            setState(() {
              // Encuentra el ID del oficio seleccionado por el nombre
              int selectedId = _availableJobs
                  .firstWhere((oficio) => oficio.nombreOficio == newValue)
                  .idOficio;
              _selectedJobs[index] = selectedId;  // Actualiza el ID en lugar del nombre
            });
          },
          items: _availableJobs.map((oficio) {
            return DropdownMenuItem(
              value: oficio.nombreOficio,
              child: Text(oficio.nombreOficio),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cambiar Oficios'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Generar dropdown para cada oficio
            for (int i = 0; i < widget.tecnico.oficios.length; i++)
              _buildJobDropdown(i),
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
                      if (_selectedJobs.isNotEmpty && _passwordController.text.isNotEmpty) {
                        setState(() {
                          _isLoading = true;
                        });
                        try {
                          // Enviar la solicitud para cambiar los oficios
                          final response = await _profileRepository.updateJobs(
                            widget.tecnico.idTecnico,
                            _selectedJobs,  // Enviar IDs de los oficios seleccionados
                            _passwordController.text,
                          );

                          // Navegar de vuelta al perfil
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfilePage(
                                idTecnico: widget.tecnico.idTecnico,
                              ),
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: ${e.toString()}')),
                          );
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
                    child: const Text('Guardar Cambios'),
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
