
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mesadeayuda/src/models/Prioridad.dart';
import 'package:mesadeayuda/src/models/area_servicios.dart';
import 'package:mesadeayuda/src/models/fallas.dart';
import 'package:mesadeayuda/src/models/personal.dart';
import 'package:mesadeayuda/src/models/user_respuesta_login.dart';
import 'package:mesadeayuda/src/utils/shared_pref.dart';
import 'package:sn_progress_dialog/enums/value_position.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../../../models/Message.dart';
import '../../../models/TicketsInfo.dart';
import '../../../models/solicitud_atendio.dart';
import '../../../models/ticket_detalle.dart';
import '../../../providers/tickets_providers.dart';
import '../../../utils/my_snackbar.dart';
import 'list/list_tickets_page.dart';


class TicketsController {
  late BuildContext context;
  SharedPref _sharedPref = new SharedPref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  late Function refresh;
  List<String> taps = ['Detalles', 'Chat'];
  List<String> reasignarTicket = <String>['No','Si'];
  List<String> cambiarEstatus = <String>['abierto','cerrado','respondido','reabierto'];
  String valorReasignar='No';
  String valorcambiarEstatus='abierto';
  String valorAtendio='Selecciona';
  String valorAreaServicio='Selecciona';
  String valorAreaServicioId='0';
  String valorFalla='Selecciona'; // en al cinsulta aplcia run order by para que depues concuerde

  List<Personal> listaPersonal = [Personal(nombre: "Selecciona", departamento: "Selecciona")];
  List<AreaServicios> listaareaServicio = [AreaServicios(id: 0, clave: "Selecciona")];
  List<Fallas> listafallas = [Fallas(id: 0, falla: 'Selecciona', prioridad: 0, tiempo: 0, departamentoId: 0, categoriaId: 0, clasificacionId: 0)];
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
  String idticket='';
  String fechacreado='';
  String tiemporespuesta='';
  String solicitudreabrir='';
  late ProgressDialog _progressDialog;

  Future<void> init(BuildContext context, Function refresh, String clave, String idTicket) async {
     this.context=context;
     this.refresh=refresh;
     idticket=idTicket;
     await ticketsProviders.init(context);
     _progressDialog=ProgressDialog(context: context);
     consultarTicket(clave, idTicket);
     consultarPersonal();
     consultarArea();     
     prioridades();
     mostraAtendidoFecha();
     mostraAreaFalla();
     refresh();

  }
  String formatTimeOfDay(TimeOfDay time) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }
  void guardar() async {
    String id = idticket;
    String dropEstatus = valorcambiarEstatus;
    String dropAtendio = valorAtendio;
    String fecha = selectedDate.toString();
    String hora = formatTimeOfDay(selectedTime!);

    if ([dropEstatus, dropAtendio, fecha, hora].contains('Selecciona') || fecha.isEmpty || hora.isEmpty) {
      MySnackBar.show(context, 'Debes ingresar todos los campos');
      return;
    }

    SolicitudAtendio solicitudAtendio = new SolicitudAtendio(
        id: id,
        estatus: dropEstatus,
        atendio: dropAtendio,
        fecha: fecha,
        hora: hora,
        fechacreado: fechacreado,
        tiemporespuesta: tiemporespuesta,
        solicitudreabrir: solicitudreabrir
    );
    _progressDialog.show(max: 100, msg: 'Espera un momento...' ,
        backgroundColor: Colors.orange , msgColor: Colors.black,
        progressBgColor: Colors.black,  msgTextAlign: TextAlign.center,
        msgFontWeight: FontWeight.bold, msgFontSize: 20,
        valuePosition: ValuePosition.center  );

    final res =  await ticketsProviders.updateTicket(solicitudAtendio);
    if (res){
      _progressDialog.close();
      MySnackBar.show(context, 'Ticket Actualizado');
      await Future.delayed(Duration(seconds: 3));
      Navigator.push( context, MaterialPageRoute(builder: (context) => const ListTicketsPage()),
      );
    }else{
      _progressDialog.close();
      MySnackBar.show(context, 'Ocurrio un error al actulizar el ticket');
    }

  }
  void consultarTicket(String clave, String ticketId) async {
    _progressDialog.show(max: 100, msg: 'Espera un momento...' ,
        backgroundColor: Colors.orange , msgColor: Colors.black,
        progressBgColor: Colors.black,  msgTextAlign: TextAlign.center,
        msgFontWeight: FontWeight.bold, msgFontSize: 20,
        valuePosition: ValuePosition.center  );

    ticketDetalle.clear();
    ticketDetalle = await ticketsProviders.consultarTicket(clave,ticketId);
    valorcambiarEstatus= ticketDetalle[0].tickets[0].estatus;
    valorAtendio = (ticketDetalle[0].tickets[0].atendio != null && ticketDetalle[0].tickets[0].atendio.isNotEmpty)
        ? ticketDetalle[0].tickets[0].atendio
        : 'Selecciona';

    selectedDate = (ticketDetalle[0].tickets[0].fecha_atendido != null &&
        ticketDetalle[0].tickets[0].fecha_atendido.isNotEmpty)
        ? DateTime.parse(ticketDetalle[0].tickets[0].fecha_atendido)
        : DateTime.now();

    selectedTime = (ticketDetalle[0].tickets[0].fecha_atendido != null &&
        ticketDetalle[0].tickets[0].fecha_atendido.isNotEmpty)
        ? TimeOfDay.fromDateTime(DateTime.parse(ticketDetalle[0].tickets[0].fecha_atendido))
        : TimeOfDay.fromDateTime(DateTime.now());

    valorAreaServicio=(ticketDetalle[0].tickets[0].servicio != null &&
                      ticketDetalle[0].tickets[0].servicio.isNotEmpty)
                  ? ticketDetalle[0].tickets[0].servicio
                      : 'Selecciona';


    valorAreaServicioId = listaareaServicio
        .firstWhere((area) => area.clave == valorAreaServicio)
        .id.toString();

    consultaFallas(valorAreaServicioId);

    valorFalla=(ticketDetalle[0].tickets[0].falla != null &&
                      ticketDetalle[0].tickets[0].falla.isNotEmpty)
                  ? ticketDetalle[0].tickets[0].falla
                      : 'Selecciona';


    txtareencargada.text= valorAreaServicio;
    txtprioridad.text = (ticketDetalle[0].tickets[0].prioridad != null &&
                      ticketDetalle[0].tickets[0].prioridad.isNotEmpty)
                  ? ticketDetalle[0].tickets[0].prioridad
                      : '';

    fechacreado=(ticketDetalle[0].tickets[0].fecha_creado != null &&
        ticketDetalle[0].tickets[0].fecha_creado.isNotEmpty)
        ? ticketDetalle[0].tickets[0].fecha_creado
        : '';

    tiemporespuesta = (ticketDetalle[0].tickets[0].tiempo_respuesta!= null &&
        ticketDetalle[0].tickets[0].tiempo_respuesta.isNotEmpty)
        ? ticketDetalle[0].tickets[0].tiempo_respuesta
        : '';

    solicitudreabrir = (ticketDetalle[0].tickets[0].solicitud_reabrir!= null &&
        ticketDetalle[0].tickets[0].solicitud_reabrir.isNotEmpty)
        ? ticketDetalle[0].tickets[0].solicitud_reabrir
        : '';
    _progressDialog.close();


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
  void consultaFallas(String clasificacion) async {
    listafallas.clear();
    listafallas = await ticketsProviders.consulTaFallas(clasificacion);
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
    if(valorcambiarEstatus == 'cerrado'){
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
    if(valorReasignar == 'Si' && valorcambiarEstatus != 'cerrado'){
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