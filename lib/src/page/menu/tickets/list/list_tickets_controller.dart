
import 'package:flutter/material.dart';
import 'package:mesadeayuda/src/models/Tickets.dart';
import 'package:mesadeayuda/src/models/user_respuesta_login.dart';
import 'package:mesadeayuda/src/providers/tickets_providers.dart';
import 'package:mesadeayuda/src/utils/shared_pref.dart';

import '../../../../models/usuario.dart';
import '../../../../utils/my_snackbar.dart';



class ListTicketsController {
  late BuildContext context;
  TicketsProviders ticketsProviders = new TicketsProviders();
  SharedPref _sharedPref  = new SharedPref();
  late Function refresh;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  List<Tickets> tickets = [Tickets(id: 0, clave: "1", falla: "1")];
  List<Tickets> ticketsList = [Tickets(id: 0, clave: "1", falla: "1")];
  late Usuario user;
  TextEditingController searchController = TextEditingController();
  late UserRespuestaLogin userLogin;
  Future<void> init(BuildContext context, Function refresh) async {
    this.context=context;
    this.refresh=refresh;
    await ticketsProviders.init(context);
    user = Usuario.fromJson(await _sharedPref.read('userLogin'));
    consultarTickets(user.usuarios!.departamentoClave);
    refresh();
  }
  void logout(){
    _sharedPref.logout(context);
  }

  void gotoUpdateTicketPage(){
    Navigator.pushNamed(context, 'menu/tickets/list');
  }


  void consultarTickets(String departamento) async {
    tickets.clear();
    tickets = await ticketsProviders.consultarTickets(departamento);
    ticketsList.clear();
    ticketsList=tickets;

    if (tickets.isEmpty){
      MySnackBar.show(context, 'No existen tickes abiertos');
    }
    refresh();
  }

  void searchTickets(String valor) {
    if (valor.isEmpty) {
      tickets = List.from(ticketsList); // Muestra todos los tickets si no hay búsqueda
    } else {
      tickets = ticketsList
          .where((ticket) => ticket.clave.toLowerCase().contains(valor.toLowerCase()) ||
          ticket.falla.toLowerCase().contains(valor.toLowerCase()))
          .toList();
    }
    refresh();
  }



  void openDrawer(){
    key.currentState?.openDrawer();
  }
}