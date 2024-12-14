import 'package:flutter/material.dart';
import '../../data/models/tecnico.dart'; // Modelo Técnico
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
  final _profileRepository = PerfilRepository(DioInstance().getApiService());
  List<int?> _selectedJobs = [];
  List<Oficio> _availableJobs = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadAvailableJobs();
    _selectedJobs = widget.tecnico.oficios.map((e) => e.idOficio).toList();
  }

  Future<void> _loadAvailableJobs() async {
    try {
      final response = await _profileRepository.getAvailableJobs();
      setState(() {
        _availableJobs = response;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar los oficios: ${e.toString()}')),
      );
    }
  }

  void _addNewJob() {
    setState(() {
      _selectedJobs.add(null); // Añadir una nueva fila vacía
    });
  }

  void _removeJob(int index) {
    setState(() {
      _selectedJobs.removeAt(index); // Eliminar la fila seleccionada
    });
  }

  Future<void> _saveChanges() async {
    // Validar campos vacíos
    if (_selectedJobs.contains(null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pueden guardar filas con oficios vacíos')),
      );
      return;
    }

    // Validar duplicados
    if (_selectedJobs.length != _selectedJobs.toSet().length) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se permiten oficios duplicados')),
      );
      return;
    }

    // Validar contraseña y enviar cambios
    if (_passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingrese su contraseña')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _profileRepository.updateJobs(
        widget.tecnico.idTecnico,
        _selectedJobs.cast<int>(), // Convertir a lista de enteros
        _passwordController.text,
      );

      if (response['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Oficios cambiados correctamente')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(
              idTecnico: widget.tecnico.idTecnico,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response['message']}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildJobDropdown(int index) {
    final currentJob = widget.tecnico.oficios[index].nombreOficio;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Oficio actual: $currentJob',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 5),
              DropdownButtonFormField<int>(
                value: _selectedJobs[index],
                decoration: const InputDecoration(
                  labelText: 'Selecciona un oficio',
                  border: OutlineInputBorder(),
                ),
                onChanged: (newValue) {
                  setState(() {
                    _selectedJobs[index] = newValue;
                  });
                },
                items: _availableJobs.map((oficio) {
                  return DropdownMenuItem(
                    value: oficio.idOficio,
                    child: Text(oficio.nombreOficio),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close, color: Colors.red),
          onPressed: () {
            _removeJob(index);
          },
        ),
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
            Expanded(
              child: ListView.builder(
                itemCount: _selectedJobs.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: _buildJobDropdown(index),
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: _addNewJob,
              icon: const Icon(Icons.add),
              label: const Text('Añadir nuevo oficio'),
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
                    onPressed: _saveChanges,
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
