import 'package:flutter/material.dart';

class PanelAdmin extends StatelessWidget {
  const PanelAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('VaporBooking')),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Panel de administración',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 8),

            Text('Resumen de la actividad'),

            SizedBox(height: 24),

            //creamos las tarjetas con los ingresos
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),

              child: Column(
                children: [
                  Text('Ingresos de hoy'),

                  SizedBox(height: 12),

                  Text(
                    '200,00€',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 12),

                  Text('Facturación de hoy'),
                ],
              ),
            ),

            SizedBox(height: 24),

            //apartado del resumen de citas
            Text(
              'Resumen de citas',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 16),

            //citas de ejemplo
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),

              child: Column(
                children: [
                  Text(
                    'Masaje - 09:30',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 12),

                  Text('Kade Voronin - 60 min'),
                ],
              ),
            ),

            SizedBox(height: 12),

            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),

              child: Column(
                children: [
                  Text(
                    'Estética - 12:00',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 12),

                  Text('Nico Ortega - 45 min'),
                ],
              ),
            ),

            SizedBox(height: 12),

            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),

              child: Column(
                children: [
                  Text(
                    'Solárium - 18:00',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 12),

                  Text('Nora Serra - 20 min'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
