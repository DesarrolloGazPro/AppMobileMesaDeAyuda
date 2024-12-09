import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mesadeayuda/src/models/Tickets.dart';
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
        preferredSize: Size.fromHeight(170),
        child: AppBar(
          title: Container(
            alignment: Alignment.center,
            child: Text('Tickes', style: TextStyle(
              color: Colors.white
            ),),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.primaryColor,

          actions: [

            _recargar(),

          ],
          flexibleSpace: Column(
            children: [
              const SizedBox(height: 60),
              _menuDrawer(),
              const SizedBox(height: 2),
              _textFieldSearch(),
              const SizedBox(height: 5),

              Text(
            'Total Abiertos: ${_con.tickets.length}',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
          ),

              // _texFieldSerach(),
            ],
          ),
        ),
      ) ,
      drawer: _drawer(),
        body: _con.tickets.isEmpty
            ? Center(child: Text('No se encontraron resultados'))
            : ListView.builder(
          itemCount: _con.tickets.length,
          itemBuilder: (context, index) {
            return TicketTile(ticket: _con.tickets[index]);
          },
        ),
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
            offset: Offset(0, 2),

          ),
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 20),
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
          contentPadding: EdgeInsets.all(15),
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
                  'Email',
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade300,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic
                  ),
                  maxLines: 1,
                ),

                Text(
                  'Telefono',
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
            title: Text('Mis Tickets', style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold),),
            // trailing: Icon(Icons.airplane_ticket) ,
            leading: Icon(Icons.airplane_ticket),
          ),
          ListTile(
            onTap: _con.logout,
            title: Text('Cerrar session', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            // trailing: Icon(Icons.airplane_ticket) ,
            leading: Icon(Icons.power_settings_new),
          ),
        ],
      ),
    );
  }



  Widget _recargar(){
    return GestureDetector(
      onTap: refresh,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 15, top: 32),
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
  final Tickets ticket;

  TicketTile({required this.ticket});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => TicketsPage(clave: ticket.clave,)

        ));
      },
      child: Container(
        height: 150,
        child: Card(
          elevation: 15,
          color: Colors.white60,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(

            title: Text('Clave: ${ticket.clave ?? ''}', style: TextStyle(fontSize: 20)),
            subtitle: Text('Descripción: ${ticket.falla ?? ''}', style: TextStyle(fontSize: 17)),
            trailing: Icon(Icons.info_outline, color: MyColors.primaryColor),
          ),
        ),
      ),
    );
  }
}
