import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:mesadeayuda/src/models/TicketsInfo.dart';
import 'package:mesadeayuda/src/page/menu/tickets/tickets_page.dart';
import 'package:mesadeayuda/src/utils/my_colors.dart';

import 'list_tickets_controller.dart';

class ListTicketsPage extends StatefulWidget {
  const ListTicketsPage({super.key});

  @override
  State<ListTicketsPage> createState() => _ListTicketsPageState();
}

class _ListTicketsPageState extends State<ListTicketsPage> {
  ListTicketsController _con = new ListTicketsController();
  @override
  void initState(){
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context,refresh);
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.key,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(230),
        child: AppBar(
          title: Container(
            alignment: Alignment.center,
            child: const Text('Tickes', style: TextStyle(
              color: Colors.white
            ),),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,

          actions: [
            _recargar(),
          ],
          flexibleSpace: Column(
            children: [
              const SizedBox(height: 60),
              _menuDrawer(),
              const SizedBox(height: 20),
              _textFieldSearch(),

              const SizedBox(height: 10),

              Row(

                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                                ''
                                    'Tickets: ${_con.tickets.length}',
                                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                                ),
                              ),
                  ),
                const Spacer(),
                  _dropCambiarestatus()
                ],
              ),
            ],
          ),
        ),
      ) ,
      drawer: _drawer(),
        body: _con.tickets.isEmpty
            ? const Center(child: Text('No se encontraron resultados'))
            : Scrollbar(
          thumbVisibility: true,
              thickness:10,
              radius: const Radius.circular(10),
              interactive: true,
              child: ListView.builder(
                        itemCount: _con.tickets.length,
                        itemBuilder: (context, index) {
              return TicketTile(ticket: _con.tickets[index]);
                        },
                      ),
            ),
    );
  }
  Widget _dropCambiarestatus(){
    String dropdownValue = _con.cambiarEstatus.first;
    return Column(
      children: [
        Container(
          width: 180,
          decoration: BoxDecoration(
            color:MyColors.primaryOpacityColor,
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: DropdownButton<String>(
            value: _con.valorcambiarEstatus,
            icon: const Icon(Icons.arrow_downward, color: Colors.white,),
            elevation: 16,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),

            onChanged: (String? value) {
              setState(() { });
            _con.valorcambiarEstatus=value!;
              _con.searchTicketsPorEstatus(_con.valorcambiarEstatus);

            },
            isExpanded: true,
            items: _con.cambiarEstatus.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style:  TextStyle(fontSize: 20, color: Colors.orange),),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _textFieldSearch() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(0, 2),

          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: _con.searchController,
        onChanged: (value) {
          _con.searchTickets(value);
        },
        decoration: InputDecoration(
          hintText: 'Buscar',
          suffixIcon: Icon(
            Icons.search,
            color: Colors.grey[400],
          ),
          hintStyle: TextStyle(
            fontSize: 20,
            color: Colors.grey[500],
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: MyColors.primaryColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: MyColors.primaryColor,
            ),
          ),
          contentPadding: const EdgeInsets.all(15),
        ),
      ),
    );
  }

  Widget _menuDrawer(){
    return GestureDetector(
      onTap: _con.openDrawer,
      child: Container(

          margin: const EdgeInsets.only(left: 20),
          alignment: Alignment.centerLeft,
          child: const Icon(
            Icons.menu,
            color: Colors.white,
            size: 30,
          )

      ),
    );
  }
  Widget _drawer(){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
                color: MyColors.primaryColor
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('',
                  //_con.userLogin.usuarios?.nombre ?? '',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                  maxLines: 1,
                ),
                Text(
                     _con.user?.usuarios?.nombre ?? '',                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade300,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic
                  ),
                  maxLines: 1,
                ),

                Text(
                   _con.user?.usuarios?.correo ?? '',
                  
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade300,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic
                  ),
                  maxLines: 1,
                ),
                Container(
                  height: 60,
                  margin: const EdgeInsets.only(top: 1),
                  child: const FadeInImage(
                    image: AssetImage('assets/img/waze.png'),
                    fadeInDuration: Duration(milliseconds: 50),
                    placeholder: AssetImage('assets/img/waze.png'),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            onTap: _con.gotoUpdateTicketPage,
            title: const Text('Mis Tickets', style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold),),
            // trailing: Icon(Icons.airplane_ticket) ,
            leading: const Icon(Icons.airplane_ticket),
          ),
          ListTile(
            onTap: _con.logout,
            title: const Text('Cerrar session', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
            // trailing: Icon(Icons.airplane_ticket) ,
            leading: const Icon(Icons.power_settings_new),
          ),
        ],
      ),
    );
  }



  Widget _recargar(){
    return GestureDetector(
      onTap: (){
        _con.consultarTickets(_con.departamentoClave,_con.usuarioClavePerfil, _con.usuarioId);
        _con.valorcambiarEstatus='todos';


      },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10, top: 30),
            child: const Icon(
              Icons.refresh,
              color: Colors.white,
               size: 30,
            ),
          ),

        ],
      ),
    );
  }

  void refresh(){
    setState(() {});
  }
}


class TicketTile extends StatelessWidget {
  final TicketsInfo ticket;

  TicketTile({required this.ticket});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => TicketsPage(clave: ticket.clave, idTicket: ticket.id.toString(),)

        ));
      },
      child: Column(
        children: [
          Card(
            elevation: 5,
            color: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    'No. Ticket: ${ticket.clave ?? ''}',
                    style: TextStyle(fontSize: 15, color: Colors.blue.shade900),
                  ),
                  subtitle: Text(
                    'Descripción: ${ticket.falla ?? ''}',
                    style: TextStyle(fontSize: 15, color: Colors.green.shade900),
                  ),
                  trailing: Icon(Icons.info, color: getColorForStatus(ticket.estatus)),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text('T.R', style: TextStyle(color: Colors.blue.shade900)),
                          Text(ticket.tiempo_respuesta),
                        ],
                      ),
                      const SizedBox(width: 10,),
                      Column(
                        children: [
                          Text('T.T',
                            style: TextStyle(color: Colors.blue.shade900),
                          ),
                          Text(calcularTiempoTranscurrido() + " hrs"),
                        ],
                      ),
                      const SizedBox(width: 10,),
                      Column(
                        children: [
                          Text('Estacion/Departamento', style: TextStyle(color: Colors.blue.shade900)),
                          Text(ticket.usuario_sucursal_nombre)
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  padding: const EdgeInsets.only(left: 15, bottom: 10),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text('Area que atiende', style: TextStyle(color: Colors.blue.shade900)),
                          Text(ticket.usuario_asignado)
                        ],
                      ),
                      const SizedBox(width: 10,),
                      Expanded(

                        child: Column(
                          children: [
                            Text('Estatus', style: TextStyle(color: Colors.blue.shade900)),
                            Text(ticket.estatus)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color getColorForStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'abierto':
        return Colors.blue.shade900; // Verde para abierto
      case 'cerrado':
        return Colors.red.shade900; // Rojo para cerrado
      case 'respondido':
        return Colors.brown.shade900; // Azul para respondido
      case 'reabierto':
        return Colors.orange.shade900; // Naranja para reabierto
      default:
        return Colors.black; // Color predeterminado
    }
  }

  String calcularTiempoTranscurrido(){

    if (ticket.fecha_creado=="") return "";

    DateFormat formato= DateFormat("MM/dd/yyyy HH:mm");

    DateTime actual= DateTime.now();
    DateTime fechacreado= formato.parse(ticket.fecha_creado);
     Duration diferencia= actual.difference(fechacreado);
     int horas= diferencia.inHours;
     return horas.toString();


  }
}
