
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mesadeayuda/src/models/Prioridad.dart';
import 'package:mesadeayuda/src/models/area_servicios.dart';
import 'package:mesadeayuda/src/models/fallas.dart';
import 'package:mesadeayuda/src/models/personal.dart';
import 'package:mesadeayuda/src/models/user_respuesta_login.dart';
import 'package:mesadeayuda/src/utils/shared_pref.dart';

import '../../../models/Message.dart';
import '../../../models/TicketsInfo.dart';
import '../../../models/ticket_detalle.dart';
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
  String valorAreaServicio='Sistemas operaciones';
  String valorFalla='Apagon General'; // en al cinsulta aplcia run order by para que depues concuerde

  List<Personal> listaPersonal = [Personal(nombre: "Selecciona", departamento: "Selecciona")];
  List<AreaServicios> listaareaServicio = [AreaServicios(id: 12, clave: "Sistemas operaciones")];
  List<Fallas> listafallas = [Fallas(id: 1, falla: 'Apagon General', prioridad: 2, tiempo: 4, departamentoId: 1, categoriaId: 42, clasificacionId: 12)];
  List<Prioridad> listaprioridad = [];

  late TicketsInfo ticket;

  List<TicketDetalle> ticketDetalle = [];



  List<Message> messageList = [
    Message(text: 'Hola como estas!', fromWho: 'ella'),
    Message(text: 'Bine y tu!', fromWho: 'yo'),

  ];
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  TextEditingController txtareencargada = TextEditingController();
  TextEditingController txtprioridad = TextEditingController();
  bool mostrarAtendido=false;
  bool mostrarArea =false;
  bool mostrarReasignarTicket =false;

  late UserRespuestaLogin userLogin;
  TicketsProviders ticketsProviders = new TicketsProviders();
  XFile? pickedFile;
  File? imageFile;


  Future<void> init(BuildContext context, Function refresh, String clave, String idTicket) async {
     this.context=context;
     this.refresh=refresh;
     await ticketsProviders.init(context);
     consultarTicket(clave, idTicket);
     consultarPersonal();
     consultarArea();
     consultaFallas();
     prioridades();
   //  txtareencargada.text = valorAreaServicio;
  //   txtprioridad.text = listaprioridad.first.clave;


     mostraAtendidoFecha();
     mostraAreaFalla();
     refresh();

  }

  void consultarTicket(String clave, String ticketId) async {
    ticketDetalle.clear();
    ticketDetalle = await ticketsProviders.consultarTicket(clave,ticketId);

    if (ticketDetalle.isEmpty){
      MySnackBar.show(context, 'No existen ticket');
    }
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
    listaPersonal.clear();
    listaPersonal = await ticketsProviders.consulTaPersonal('Gerencia de Desarrollo');
    if (listaPersonal.isEmpty){
      MySnackBar.show(context, 'No existen datos');
    }
    refresh();
  }

  void consultarArea() async {
    listaareaServicio.clear();
    listaareaServicio = await ticketsProviders.consulTaArea();
    if (listaareaServicio.isEmpty){
      MySnackBar.show(context, 'No existen datos');
    }
    refresh();
  }
  void consultaFallas() async {
    listafallas.clear();
    listafallas = await ticketsProviders.consulTaFallas(12);
    if (listafallas.isEmpty){
      MySnackBar.show(context, 'No existen datos');
    }
    refresh();
  }

  void prioridades() async {
    listaprioridad.clear();
    listaprioridad = await ticketsProviders.consulTaPrioridades();
    if (listaprioridad.isEmpty){
      MySnackBar.show(context, 'No existen datos');
    }
    refresh();
  }

  void mostraAtendidoFecha(){
    if(valorcambiarEstatus == 'Cerrado'){
       mostrarAtendido=true;
       mostrarReasignarTicket=false;
       mostrarArea=false;
    }else{
      mostrarAtendido=false;
      mostrarReasignarTicket=true;
    }
    refresh;
  }

  void mostraAreaFalla(){
    if(valorReasignar == 'Si' && valorcambiarEstatus != 'Cerrado'){
      mostrarArea=true;
    }else{
      mostrarArea=false;
    }
    refresh;
  }



  Future selectImage(ImageSource imageSource) async{
    pickedFile = await ImagePicker().pickImage(source: imageSource);

    if(pickedFile != null){
      imageFile=File(pickedFile!.path);
    }

    Navigator.pop(context);

    refresh();
  }

  void showAlertDialog(){
    // Widget galleryButton= ElevatedButton(
    //     onPressed: (){
    //       selectImage(ImageSource.gallery);
    //     },
    //     child: Text('GALERIA')
    // );

    Widget camaraButton= IconButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange.shade900,
            foregroundColor: Colors.white,
        ),
        onPressed: (){
          selectImage(ImageSource.camera);

        },
        icon: const Icon(Icons.camera_alt, weight: 50,),
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona tu imagen'),
      actions: [
        //galleryButton,
        camaraButton
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context){
          return alertDialog;
        });
  }
}