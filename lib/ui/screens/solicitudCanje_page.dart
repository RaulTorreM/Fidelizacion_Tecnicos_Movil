import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import '../../logic/recompensa_bloc.dart';
import '../../logic/profile_bloc.dart';
import '../../logic/solicitud_canje_bloc.dart';
import '../../data/models/venta_intermediada.dart';
import '../../data/repositories/solicitudcanje_repository.dart';
import '../../data/models/recompensa.dart';
import '../../data/models/solicitud_canje.dart';
import '../../data/models/solicitud_canje_recompensa.dart';
import '../../services/api_service.dart';

class SolicitudCanjePage extends StatefulWidget {
  final String idTecnico;

  const SolicitudCanjePage({Key? key, required this.idTecnico}) : super(key: key);

  @override
  _SolicitudCanjePageState createState() => _SolicitudCanjePageState();
}

class _SolicitudCanjePageState extends State<SolicitudCanjePage> {
  late TextEditingController _comprobanteController;
  late TextEditingController _cantidadController;
  late SolicitudCanjeBloc solicitudCanjeBloc;
  final ApiService _apiService = DioInstance().getApiService();

  int _cantidadRecompensa = 1;
  Recompensa? _selectedRecompensa;
  VentaIntermediada? _selectedVenta = null;
  List<Map<String, dynamic>> _recompensasAgregadas = [];
  int _puntosCanjeados = 0;
  late Future<List<VentaIntermediada>> _ventas;

  @override
  void initState() {
    super.initState();
    _comprobanteController = TextEditingController();
    _cantidadController = TextEditingController();
    _ventas = _fetchVentas();

    solicitudCanjeBloc = SolicitudCanjeBloc(
      solicitudCanjeRepository: SolicitudCanjeRepository(apiService: _apiService),
    );

    Future.microtask(() {
      final profileBloc = Provider.of<ProfileBloc>(context, listen: false);
      profileBloc.fetchPerfil(widget.idTecnico);

      final recompensasBloc = Provider.of<RecompensaBloc>(context, listen: false);
      recompensasBloc.obtenerRecompensas();
    });
  }

  Future<List<VentaIntermediada>> _fetchVentas() async {
    List<VentaIntermediada> ventas = await _apiService.getVentasIntermediadasSolicitudes(widget.idTecnico);
    return ventas.where((venta) => venta.idEstadoVenta == 1 || venta.idEstadoVenta == 2).toList();
  }

  String obtenerNumeroSolicitud(String idSolicitudCanje) {
    return idSolicitudCanje.split('-').last;
  }

  @override
  void dispose() {
    solicitudCanjeBloc.dispose();
    _comprobanteController.dispose();
    _cantidadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Nuevo Canje', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Color.fromARGB(255, 42, 93, 175), // Color moderno
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoText(),
              SizedBox(height: 16),
              _buildTechnicianInfo(),
              SizedBox(height: 16),
              _buildComprobanteField(),
              SizedBox(height: 16),
              _buildRewardSelection(),
              SizedBox(height: 16),
              _buildRewardsTable(),
              SizedBox(height: 16),
              _buildResumen(),
              SizedBox(height: 16),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoText() {
    return Text(
      'Solo se pueden canjear las ventas intermediadas que tengan el estado En espera o Redimido (parcial).',
      style: TextStyle(fontSize: 14, color: Colors.grey, fontStyle: FontStyle.italic),
    );
  }

 Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: _limpiarTabla,
              icon: Icon(Icons.delete, color: Colors.white),
              label: Text('Limpiar Tabla'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 86, 147, 221), // Color más claro y visible
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 5, // Sombra para un aspecto más profesional
              ),
            ),
            SizedBox(width: 20),
            ElevatedButton.icon(  
              onPressed: () {
                mostrarConfirmacionCanje(
                  context: context,
                  mensaje: '¿Estás seguro de realizar esta solicitud? \nNo podrás realizar nuevas solicitudes con la misma venta hasta que haya sido Aprobado o Rechazado',
                  onConfirmar: _guardarCanje,
                );
              },
              icon: Icon(Icons.check, color: Colors.white),
              label: Text('Guardar Canje'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 5,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> mostrarConfirmacionCanje({
    required BuildContext context,
    required String mensaje,
    required VoidCallback onConfirmar,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Canje', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text(mensaje),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No', style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirmar();
              },
              child: Text('Sí'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTechnicianInfo() {
    return Consumer<ProfileBloc>(
      builder: (context, profileBloc, child) {
        if (profileBloc.isLoading) {
          return CircularProgressIndicator();
        }

        if (profileBloc.error != null) {
          return Text(profileBloc.error ?? 'Error al cargar el perfil');
        }

        final tecnico = profileBloc.tecnico;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Técnico"),
            TextField(
              enabled: false,
              decoration: InputDecoration(
                hintText: tecnico?.nombreTecnico ?? 'Cargando...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            Text("Total de puntos"),
            TextField(
              enabled: false,
              decoration: InputDecoration(
                hintText: tecnico?.totalPuntosActualesTecnico.toString() ?? 'Cargando...',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildComprobanteField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Número de comprobante"),
        _buildComprobantesDropdown(),
      ],
    );
  }

  Widget _buildComprobantesDropdown() {
    return FutureBuilder<List<VentaIntermediada>>(
      future: _ventas, // El Future que contiene la lista de ventas
      builder: (context, snapshot) {
        // Verificamos el estado de la respuesta
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return _buildDropdownPlaceholder("No hay comprobantes disponibles.");
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return _buildDropdownPlaceholder("No hay comprobantes disponibles.");
        }

        List<VentaIntermediada> ventas = snapshot.data!;

        return DropdownButton<VentaIntermediada>(
          value: _selectedVenta,
          items: ventas.map((VentaIntermediada venta) {
            return DropdownMenuItem<VentaIntermediada>(
              value: venta,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'N°: ${obtenerNumeroSolicitud(venta.idVentaIntermediada)}',
                    style: TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "${venta.puntosActuales_VentaIntermediada} Pts",
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (VentaIntermediada? newValue) {
            setState(() {
              _selectedVenta = newValue;
              _comprobanteController.text = newValue?.idVentaIntermediada ?? '';
            });
          },
          hint: Text("Selecciona comprobante"),
        );
      },
    );
  }

  /// Placeholder discreto cuando no hay datos o hay un error
  Widget _buildDropdownPlaceholder(String message) {
    return Container(
      height: 48, // Altura similar a la de un DropdownButton
      padding: EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade400),
        color: Colors.grey.shade100,
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, size: 20, color: Colors.grey.shade600),
          SizedBox(width: 8),
          Flexible(
            child: Text(
              message,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  
  Widget _buildRewardSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Selecciona recompensa"),
        Consumer<RecompensaBloc>(
          builder: (context, recompensasBloc, child) {
            if (recompensasBloc.isLoading) {
              return CircularProgressIndicator(); // Muestra un indicador de carga
            }

            if (recompensasBloc.errorMessage != null) {
              return Text('Error: ${recompensasBloc.errorMessage}');
            }

            // Validar si hay un comprobante seleccionado
            final isDropdownEnabled = _selectedVenta != null;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dropdown para seleccionar recompensa
                DropdownButton<Recompensa>(
                  isExpanded: true, // Hace que el Dropdown ocupe todo el espacio horizontal
                  value: _selectedRecompensa,
                  items: isDropdownEnabled
                      ? recompensasBloc.recompensas.map((recompensa) {
                          return DropdownMenuItem(
                            value: recompensa,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    recompensa.descripcionRecompensa,
                                    style: TextStyle(fontSize: 16),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '${recompensa.costoPuntos_Recompensa} pts',
                                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                                ),
                                SizedBox(width: 8),
                                Text(
                                'Stock: ${recompensa.stock_Recompensa}', // Mostrar stock
                                style: TextStyle(fontSize: 14, color: Colors.green),
                              ),
                              ],
                            ),
                          );
                        }).toList()
                      : null,
                  onChanged: isDropdownEnabled
                      ? (Recompensa? newValue) {
                          setState(() {
                            _selectedRecompensa = newValue;
                          });
                        }
                      : null,
                  hint: isDropdownEnabled
                      ? Text("Selecciona recompensa")
                      : Text("Debes seleccionar un comprobante",
                          style: TextStyle(color: Colors.red)),
                  disabledHint: Text(
                    "Debes seleccionar un comprobante",
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
                SizedBox(height: 16),
                // Sección para la cantidad de recompensa
                Row(
                  children: [
                    SizedBox(width: 8),
                    Text("Cantidad"),
                    IconButton(
                      onPressed: isDropdownEnabled
                          ? () {
                              setState(() {
                                _cantidadRecompensa =
                                    (_cantidadRecompensa > 1) ? _cantidadRecompensa - 1 : 1;
                              });
                            }
                          : null,
                      icon: Icon(Icons.remove),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text('$_cantidadRecompensa'),
                    ),
                    IconButton(
                      onPressed: isDropdownEnabled
                          ? () {
                              setState(() {
                                _cantidadRecompensa++;
                              });
                            }
                          : null,
                      icon: Icon(Icons.add),
                    ),
                    SizedBox(width: 16),
                    // Botón para agregar a la tabla
                    ElevatedButton(
                      onPressed: isDropdownEnabled && _selectedRecompensa != null
                          ? _addToTable
                          : null,
                      child: Text("Añadir"),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  

  // Función para agregar recompensa a la tabla
  void _addToTable() {
    if (_selectedRecompensa != null) {
      final puntosRecompensa = _selectedRecompensa!.costoPuntos_Recompensa * _cantidadRecompensa;

      // Validar si los puntos actuales permiten agregar la recompensa
      final puntosRestantes = (_selectedVenta?.puntosActuales_VentaIntermediada ?? 0) - _puntosCanjeados;

      if (puntosRecompensa > puntosRestantes) {
        // Mostrar un mensaje de error si excede los puntos disponibles
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Las Recompensas a añadir exceden los puntos restantes.',
              style: TextStyle(fontSize: 14), // Tamaño de texto más pequeño
              textAlign: TextAlign.center, // Centrar el texto
            ),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3), // Controlar el tiempo de visualización
            behavior: SnackBarBehavior.floating, // Mostrar como un snackbar flotante
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Ajustar posición y márgenes
          ),
        );
        return; // Salir de la función sin agregar la recompensa
      }

      // Validar si el stock es suficiente
      if (_selectedRecompensa!.stock_Recompensa < _cantidadRecompensa) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No hay suficiente stock para añadir esta recompensa.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      setState(() {
        // Buscar si la recompensa ya está agregada
        final index = _recompensasAgregadas.indexWhere(
          (item) => item['idRecompensa'] == _selectedRecompensa!.idRecompensa,
        );

        if (index != -1) {
          // Si ya está agregada, actualizar la cantidad y puntos
          final recompensaExistente = _recompensasAgregadas[index];
          // Validar si el stock es suficiente
          if (_selectedRecompensa!.stock_Recompensa < recompensaExistente['cantidad']+_cantidadRecompensa) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('No hay suficiente stock para añadir esta recompensa.'),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }
          recompensaExistente['cantidad'] += _cantidadRecompensa;
          recompensaExistente['puntos'] += puntosRecompensa;
        } else {
          // Si no está, agregar una nueva recompensa
          _recompensasAgregadas.add({
            'idRecompensa': _selectedRecompensa!.idRecompensa,
            'descripcionRecompensa': _selectedRecompensa!.descripcionRecompensa,
            'cantidad': _cantidadRecompensa,
            'puntos': puntosRecompensa,
          });
        }

        // Actualizar los puntos canjeados
        _puntosCanjeados += puntosRecompensa;
      });
    }
  }




  // Widget para mostrar la tabla de recompensas agregadas
  Widget _buildRewardsTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recompensas agregadas",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        _recompensasAgregadas.isEmpty
            ? Container(
                padding: EdgeInsets.all(8),
                color: Colors.grey[200],
                child: Center(
                  child: Text("Aún no hay recompensas agregadas"),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _recompensasAgregadas.length,
                itemBuilder: (context, index) {
                  var recompensa = _recompensasAgregadas[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Descripción y cantidad
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  recompensa['descripcionRecompensa'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                Text("Cantidad: ${recompensa['cantidad']}"),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          // Puntos
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("Puntos: ${recompensa['puntos']}"),
                              IconButton(
                                onPressed: () => _removeFromTable(index),
                                icon: Icon(Icons.delete, color: Colors.red, size: 20),
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ],
    );
}


  void _removeFromTable(int index) {
  setState(() {
    // Realizamos el casting de 'Puntos' a int si es un num
    _puntosCanjeados -= (_recompensasAgregadas[index]['puntos'] as num).toInt();
    _recompensasAgregadas.removeAt(index);
  });
}



  // Widget para mostrar el resumen de puntos
  Widget _buildResumen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("RESUMEN", style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Puntos actuales"),
            // Usamos un operador de comprobación de null para evitar el error
            Text("${_selectedVenta?.puntosActuales_VentaIntermediada ?? 0}"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Puntos a canjear"),
            Text("$_puntosCanjeados"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Puntos restantes"),
            // Usamos un operador de comprobación de null aquí también
            Text("${_selectedVenta != null ? _selectedVenta!.puntosActuales_VentaIntermediada - _puntosCanjeados : 0}"),
          ],
        ),
      ],
    );
    }

    void _limpiarPage() {
    setState(() {
      // Limpiar las recompensas agregadas y los puntos canjeados
      _recompensasAgregadas.clear();
      _puntosCanjeados = 0;
      _comprobanteController.clear();
      _selectedVenta = null;
      _selectedRecompensa = null;
      _cantidadRecompensa = 1;
    });
  }

  void _limpiarTabla() {
    setState(() {
      // Limpiar las recompensas agregadas y los puntos canjeados
      _recompensasAgregadas.clear();
      _puntosCanjeados = 0;
      _comprobanteController.clear();
      _cantidadRecompensa = 1;
    });
  }

  void _guardarCanje() {
    if (_selectedVenta == null || _recompensasAgregadas.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, selecciona una venta y agrega recompensas')),
      );
      return;
    }

    // Crear la lista de recompensas usando el modelo `SolicitudCanjeRecompensa`
    final recompensas = _recompensasAgregadas.map((recompensaMap) {
      return SolicitudCanjeRecompensa(
        idRecompensa: recompensaMap['idRecompensa'],
        cantidad: recompensaMap['cantidad'],
        costoRecompensa: recompensaMap['puntos'] / recompensaMap['cantidad'],
      );
    }).toList();

    // Crear la solicitud completa usando el modelo `SolicitudCanje`
    final solicitudCanje = SolicitudCanje(
      idVentaIntermediada: _selectedVenta!.idVentaIntermediada,
      idTecnico: widget.idTecnico,
      recompensas: recompensas,
      puntosCanjeados_SolicitudCanje : _puntosCanjeados
    );


    // Mostrar un indicador de carga mientras se envía la solicitud
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Center(child: CircularProgressIndicator()),
      );

    // Llamar al Bloc para guardar la solicitud
    solicitudCanjeBloc.guardarSolicitudCanje(solicitudCanje);


    // Escuchar el estado del Bloc para manejar los resultados
    solicitudCanjeBloc.state.listen((state) {
      if (state is SolicitudCanjeLoading) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Guardando canje...')),
        );
      } else if (state is SolicitudCanjeSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Canje guardado con éxito')),
        );
        _limpiarPage(); // Limpiar datos después del éxito
      } else if (state is SolicitudCanjeFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al guardar el canje: ${state.error}')),
        );
      }
    });
    Navigator.pop(context);
    
  }

}