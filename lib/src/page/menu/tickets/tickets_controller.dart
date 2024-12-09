
import 'package:flutter/material.dart';
import 'package:mesadeayuda/src/models/personal.dart';
import 'package:mesadeayuda/src/models/user_respuesta_login.dart';
import 'package:mesadeayuda/src/utils/shared_pref.dart';

import '../../../models/Message.dart';
import '../../../providers/tickets_providers.dart';
import '../../../utils/my_snackbar.dart';

class TicketsController {
  late BuildContext context;
  SharedPref _sharedPref = new SharedPref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  late Function refresh;
  List<String> taps = ['Detalles', 'Chat'];
  List<String> reasignarTicket = <String>['No','Si'];
  List<String> cambiarEstatus = <String>['Abierto','Cerrado','Respondido','Reabierto'];
  String valorReasignar='No';
  String valorcambiarEstatus='Abierto';
  String valorAtendio='Selecciona';
  List<Personal> personal = [Personal(nombre: "Selecciona", departamento: "Selecciona")];

  List<Message> messageList = [
    Message(text: 'Hola como estas!', fromWho: 'ella'),
    Message(text: 'Bine y tu!', fromWho: 'yo'),

  ];
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  late UserRespuestaLogin userLogin;
  TicketsProviders ticketsProviders = new TicketsProviders();
  Future<void> init(BuildContext context, Function refresh) async {
     this.context=context;
     this.refresh=refresh;
     await ticketsProviders.init(context);
     consultarPersonal();
     refresh();

  }
  void logout(){
  _sharedPref.logout(context);
  }

  void goAtras(){
    Navigator.pushNamedAndRemoveUntil(context, 'menu/tickets/list', (route) =>false);

  }

  void addMessageList(String mensaje, String  fromWO){
    Message message = new Message(text: mensaje, fromWho: fromWO );
    messageList.add(message);

    refresh();
  }

  Future<void> selectDate() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ) ?? DateTime.now();

    if (picked != null && picked != selectedDate)
    {
      refresh();
      selectedDate = picked;

    }
  }

  void openDrawer(){
   key.currentState?.openDrawer();
  }

  Future<void> selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: true, // Usar formato de 24 horas
          ),
          child: child ?? SizedBox.shrink(),
        );
      },
    );

    if (picked != null && picked != selectedTime) {
        refresh();
        selectedTime = picked;

    }
  }

  void consultarPersonal() async {
    personal.clear();
    personal = await ticketsProviders.consulTaPersonal('Gerencia de Desarrollo');
    if (personal.isEmpty){
      MySnackBar.show(context, 'No existen datos');
    }
    refresh();
  }
}