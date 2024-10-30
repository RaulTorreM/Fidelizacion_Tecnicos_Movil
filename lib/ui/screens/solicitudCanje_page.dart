import 'package:flutter/material.dart';

class SolicitudCanjePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar nuevo canje'),
      ),
      body: SingleChildScrollView( // Hace desplazable toda la pantalla
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Solo se pueden canjear las ventas intermediadas que tengan el estado En espera o Redimido (parcial).',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Acción de limpiar tabla
                    },
                    child: Text('Limpiar tabla'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Acción de guardar canje
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: Text('Guardar canje'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTechnicianInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Técnico"),
        TextField(
          enabled: false,
          decoration: InputDecoration(
            hintText: '77043114 - Josué Daniel García Betancourt',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 8),
        Text("Total de puntos"),
        TextField(
          enabled: false,
          decoration: InputDecoration(
            hintText: '900',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Widget _buildComprobanteField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Número de comprobante"),
        TextField(
          decoration: InputDecoration(
            hintText: 'F001-00000073',
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.clear),
          ),
        ),
      ],
    );
  }

  Widget _buildRewardSelection() {
    return Row(
      children: [
        
        SizedBox(width: 8),
        Flexible(
          flex: 5,
          child: TextField(
            enabled: false,
            decoration: InputDecoration(
              hintText: 'RECOM-003 | EPP | Par de rodilleras...',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(width: 8),
        Text("Cantidad"),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.remove),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text('1'),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.add),
        ),
      ],
    );
}

  Widget _buildRewardsTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recompensas agregadas",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          padding: EdgeInsets.all(8),
          color: Colors.grey[200],
          child: Center(
            child: Text("Aún no hay recompensas agregadas"),
          ),
        ),
      ],
    );
  }

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
            Text("400"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Puntos a canjear"),
            Text("0"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Puntos restantes"),
            Text("400"),
          ],
        ),
      ],
    );
  }
}
