
import 'package:flutter/material.dart';
import 'package:mesadeayuda/src/models/user_respuesta_login.dart';
import 'package:mesadeayuda/src/providers/tickets_providers.dart';
import 'package:mesadeayuda/src/utils/shared_pref.dart';
import 'package:sn_progress_dialog/enums/value_position.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../../../../models/TicketsInfo.dart';
import '../../../../models/usuario.dart';
import '../../../../utils/my_snackbar.dart';



class ListTicketsController {
  late BuildContext context;
  TicketsProviders ticketsProviders = new TicketsProviders();
  SharedPref _sharedPref  = new SharedPref();
  late Function refresh;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  List<TicketsInfo> tickets = [TicketsInfo(id: 0, clave: "1", falla: "1", estatus:"", tiempo_respuesta: "", usuario_sucursal_nombre:"", usuario_asignado:"", fecha_creado:"")];
  List<TicketsInfo> ticketsList = [TicketsInfo(id: 0, clave: "1", falla: "1", estatus:"", tiempo_respuesta:"", usuario_sucursal_nombre:"", usuario_asignado:"", fecha_creado:"")];
  Usuario user=  Usuario();
  TextEditingController searchController = TextEditingController();
  late UserRespuestaLogin userLogin;
  String departamentoClave="";
  String usuarioClavePerfil="";
  String usuarioId="";
  late ProgressDialog _progressDialog;

  Future<void> init(BuildContext context, Function refresh) async {
    this.context=context;
    this.refresh=refresh;
    await ticketsProviders.init(context);
    user = Usuario.fromJson(await _sharedPref.read('userLogin'));
    _progressDialog=ProgressDialog(context: context);
    departamentoClave=user.usuarios!.departamentoClave;
    usuarioClavePerfil=user.usuarios!.perfilClave;
    usuarioId=user.usuarios!.id.toString();

    consultarTickets(departamentoClave,usuarioClavePerfil,usuarioId);
    refresh();
  }
  void logout(){
    _sharedPref.logout(context);
  }

  void gotoUpdateTicketPage(){
    Navigator.pushNamed(context, 'menu/tickets/list');
  }




  void consultarTickets(String departamento, String usuarioClavePerfil, String usuarioId ) async {
    _progressDialog.show(max: 100, msg: 'Espera un momento...' ,
        backgroundColor: Colors.white , msgColor: Colors.black,
        progressBgColor: Colors.black,  msgTextAlign: TextAlign.center,
        msgFontWeight: FontWeight.bold, msgFontSize: 15,
        valuePosition: ValuePosition.center  );

    tickets.clear();
    tickets = await ticketsProviders.consultarTickets(departamento,usuarioClavePerfil,usuarioId);
    ticketsList.clear();
    ticketsList=tickets;

    if (tickets.isEmpty){
      _progressDialog.close();
      MySnackBar.show(context, 'No existen tickes abiertos');
    }else{
      _progressDialog.close();
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