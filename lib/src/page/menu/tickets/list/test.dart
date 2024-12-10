import 'package:flutter/material.dart';



class Testtest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Listado de Tickets',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TicketListScreen(),
    );
  }
}

class TicketListScreen extends StatelessWidget {
  final List<Ticket> tickets = [
    Ticket(
      title: 'Ticket #1',
      description: 'Problema con el servidor.',
      assignedTo: 'Juan Pérez',
      date: '10/12/2024',
      status: 'Abierto',
      statusColor: Colors.green,
    ),
    Ticket(
      title: 'Ticket #2',
      description: 'Actualización de sistema requerida.',
      assignedTo: 'María López',
      date: '08/12/2024',
      status: 'Pendiente',
      statusColor: Colors.amber,
    ),
    Ticket(
      title: 'Ticket #3',
      description: 'Errores en la base de datos.',
      assignedTo: 'Carlos Sánchez',
      date: '05/12/2024',
      status: 'Cerrado',
      statusColor: Colors.red,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado de Tickets'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: tickets.length,
          itemBuilder: (context, index) {
            final ticket = tickets[index];
            return TicketCard(ticket: ticket);
          },
        ),
      ),
    );
  }
}

class Ticket {
  final String title;
  final String description;
  final String assignedTo;
  final String date;
  final String status;
  final Color statusColor;

  Ticket({
    required this.title,
    required this.description,
    required this.assignedTo,
    required this.date,
    required this.status,
    required this.statusColor,
  });
}

class TicketCard extends StatelessWidget {
  final Ticket ticket;

  const TicketCard({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ticket.title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Descripción: ${ticket.description}',
              style: TextStyle(fontSize: 14.0),
            ),
            Text(
              'Asignado a: ${ticket.assignedTo}',
              style: TextStyle(fontSize: 14.0),
            ),
            Text(
              'Fecha: ${ticket.date}',
              style: TextStyle(fontSize: 14.0),
            ),
            SizedBox(height: 8.0),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: ticket.statusColor,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  ticket.status,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
