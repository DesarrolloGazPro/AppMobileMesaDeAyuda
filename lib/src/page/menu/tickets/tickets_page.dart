import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:mesadeayuda/src/models/area_servicios.dart';
import 'package:mesadeayuda/src/models/fallas.dart';
import 'package:mesadeayuda/src/models/personal.dart';
import 'package:mesadeayuda/src/page/menu/tickets/tickets_controller.dart';
import 'package:mesadeayuda/src/utils/my_colors.dart';

import 'package:html/parser.dart' show parse;

class TicketsPage extends StatefulWidget {
  String clave;
  String idTicket;
  TicketsPage({Key? key,
    required this.clave,
    required this.idTicket
  }) : super(key: key);

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
  TicketsController _con = new TicketsController();
  @override
  void initState(){
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context,refresh, widget.clave, widget.idTicket);
    });

  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _con.key,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: AppBar(
            leading:  _Atras(),
            automaticallyImplyLeading: false,
            backgroundColor: MyColors.primaryColor,

            bottom: TabBar(
              labelStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
              indicatorColor: MyColors.primaryColor,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              isScrollable: true,
                tabs: List<Widget>.generate(2, (index) {
                  return Tab(
                    child: _con.taps.isNotEmpty
                        ? Text(_con.taps[index].toString())
                        : const Text(''),
                  );
                }),
            ),
          ),
        ) ,

        body: TabBarView(
              children: [
                _cardDetalle(),
                _cardChat(),

            ],
          ),
      ),
    );
  }
  Widget _btnEnviar(){
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed:(){},
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade900,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(vertical: 15)
        ),
        child:  const Text('Enviar', style: TextStyle(fontSize: 20)),

      ),
    );
  }

  Widget _btnGuardar(){
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: _con.isEnable ? _con.guardar : null,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade900,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(vertical: 15)
        ),
        child:  const Text('Guardar', style: TextStyle(fontSize: 20)),

      ),
    );
  }

  Widget _cardChat() {
    return Container(
      margin: const EdgeInsets.only(bottom: 100, left: 10, right: 10, top: 10),
      child: Card(
        color: Colors.white,
        elevation: 3.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(child: _chatScreen()),
                Expanded(
                    child: ListView.builder(
                        itemCount: _con.ticketDetalle.isNotEmpty && _con.ticketDetalle[0].ticketsMensajes.isNotEmpty
                            ? _con.ticketDetalle[0].ticketsMensajes.length
                            : 0,
                        itemBuilder:(context, index) {
                          final message = _con.ticketDetalle[0].ticketsMensajes[index];
                          String decodedMessage = decodeHtml(message.mensaje);
                          String replacedMessage = decodedMessage.replaceAll('<br/>', '\n');
                          return (message.esMensajeSoporte == 'SI')
                              ? _mensajeSoporte(replacedMessage)
                              : _mensajeUser(replacedMessage );
                          })),
                const SizedBox(height: 10),
                _MessageFieldBox(),
                const SizedBox(height: 20),
                _imagen(),
                const SizedBox(height: 10),
                _btnEnviar(),

              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _cardDetalle() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(bottom: 100, left: 10, right: 10, top: 10),
        child: Card(
          color: Colors.white,
          elevation: 3.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _dropCambiarestatus(),
                  const SizedBox(height: 5),
                  _dropReasignarTiket(),
                  const SizedBox(height: 10),
                  _visbleAtendioYfechaHora(),
                  const SizedBox(height: 10),
                  _visibleSelectAreafalla(),
                  const SizedBox(height: 20),
                  _btnGuardar(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _visibleSelectAreafalla(){
    return Visibility(
      visible: _con.mostrarArea,
      child: Column(
        children: [
          _dropArea(),
          const SizedBox(height: 30),
          _dropFalla(),
          const SizedBox(height: 5),
          _AreaEncargada(),
          const SizedBox(height: 5),
          _Prioridad(),
        ],
      ),
    );
  }

  Widget _visbleAtendioYfechaHora()
  {// solo se debe de mostrar cuando ele status es cerrado
    return Visibility(
      visible: _con.mostrarAtendido,
      child: Column(
        children: [
          _dropAtendio(),
          const SizedBox(height: 30),
          const Center(
            child: Text('Fecha y hora', style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _Fecha(),
                _hora(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dropReasignarTiket(){
    String dropdownValue = _con.reasignarTicket.first;
    return Visibility(
    visible: _con.mostrarReasignarTicket,
      child: Column(
        children: [
          const Text('Reasignar ticket' , style: TextStyle(
              color: Colors.black, height: 2,
              fontWeight: FontWeight.bold,
              fontSize: 20
          ),),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
             decoration: BoxDecoration(
               color:MyColors.primaryOpacityColor,
               borderRadius: BorderRadius.circular(30),
             ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: DropdownButton<String>(
             value: _con.valorReasignar,
             icon: const Icon(Icons.arrow_downward),
             elevation: 16,
             style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              borderRadius: BorderRadius.zero,
             onChanged: (String? value) {
                 refresh();
                 _con.valorReasignar = value!;
                 _con.mostraAreaFalla();

             },
              isExpanded: true,
             items: _con.reasignarTicket.map<DropdownMenuItem<String>>((String value) {
               return DropdownMenuItem<String>(
                 value: value,
                 child: Text(value , style: TextStyle(fontSize: 20),),
               );
             }).toList(),
               ),
          ),
        ],
      ),
    );
  }

  Widget _dropCambiarestatus(){
    String dropdownValue = _con.cambiarEstatus.first;
    return Column(
      children: [
        const Text('Cambiar Estatus' , style: TextStyle(
            color: Colors.black, height: 2,
            fontWeight: FontWeight.bold,
            fontSize: 20
        ),),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            color:MyColors.primaryOpacityColor,
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: DropdownButton<String>(
            value: _con.valorcambiarEstatus,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),

            onChanged: (String? value) {
              refresh();
              _con.valorcambiarEstatus = value!;
              _con.mostraAtendidoFecha();
             


            },
            isExpanded: true,
            items: _con.cambiarEstatus.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style:  TextStyle(fontSize: 20),),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _dropAtendio(){
    String dropdownValue = (_con.listaPersonal.isNotEmpty) ? _con.listaPersonal.first.nombre : '';
    return Column(
      children: [
        const Text('Atendió' , style: TextStyle(
            color: Colors.black, height: 2,
            fontWeight: FontWeight.bold,
            fontSize: 20
        ),),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            color:MyColors.primaryOpacityColor,
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: DropdownButton<String>(
            value: _con.valorAtendio,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),

            onChanged: (String? value) {
              refresh();
              _con.valorAtendio = value!;

            },
            isExpanded: true,
            items: _con.listaPersonal.map<DropdownMenuItem<String>>((Personal personal) {
              return DropdownMenuItem<String>(
                value: personal.nombre,
                child: Text(personal.nombre, style:  const TextStyle(fontSize: 20)),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }


  Widget _dropArea(){
    return Column(
      children: [
        const Text('Área' , style: TextStyle(
            color: Colors.black, height: 2,
            fontWeight: FontWeight.bold,
            fontSize: 20
        ),),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            color:MyColors.primaryOpacityColor,
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: DropdownButton<String>(
            value: (_con.valorAreaServicio != null && _con.valorAreaServicio.isNotEmpty)
                     ? _con.valorAreaServicio
                     : 'Selecciona',
           

            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),

            onChanged: (String? value) {
              refresh();
              _con.valorAreaServicio = value!;
              _con.txtareencargada.text =  _con.valorAreaServicio;

              _con.valorAreaServicioId =  _con.listaareaServicio
                  .firstWhere((area) => area.clave == value)
                  .id.toString();

              _con.consultaFallas(_con.valorAreaServicioId);
              _con.valorFalla='Selecciona';


            },
            isExpanded: true,
            items: _con.listaareaServicio.map<DropdownMenuItem<String>>((AreaServicios area) {
              return DropdownMenuItem<String>(
                value: area.clave,
                child: Text(area.clave, style:  TextStyle(fontSize: 20)),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _dropFalla(){
    return Column(
      children: [
        const Text('Falla' , style: TextStyle(
            color: Colors.black, height: 2,
            fontWeight: FontWeight.bold,
            fontSize: 20
        ),),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            color:MyColors.primaryOpacityColor,
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: DropdownButton<String>(
            value:  (_con.valorFalla != null && _con.valorFalla.isNotEmpty)
                     ? _con.valorFalla
                     : 'Selecciona'
            ,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),

            onChanged: (String? value) {
              refresh();

              _con.valorFalla = value!;
              _con.txtprioridad.text = _con.listaprioridad.firstWhere((p) => p.id == _con.listafallas.firstWhere((f) => f.falla == _con.valorFalla).prioridad).clave;

            },
            isExpanded: true,
            items: _con.listafallas.map<DropdownMenuItem<String>>((Fallas falla) {
              return DropdownMenuItem<String>(
                value: falla.falla,
                child: Text(falla.falla, style:  TextStyle(fontSize: 20)),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _Fecha() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _con.selectedDate == null
              ? ''
              : DateFormat('dd/MM/yyyy').format(_con.selectedDate!.toLocal()),
          style: const TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(width: 1),
        IconButton(
          icon: const Icon(Icons.date_range),
          style: ElevatedButton.styleFrom(
              backgroundColor: MyColors.primaryColorDark,
              foregroundColor: Colors.white,
          ),
          onPressed: (){
            _con.selectDate();
          },

        ),
      ],
    );
  }

  Widget _dropHora() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _con.selectedDate == null
              ? ''
              : DateFormat('dd/MM/yyyy').format(_con.selectedDate!.toLocal()),
          style: const TextStyle(
              fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(width: 1),
        IconButton(
          icon: const Icon(Icons.timer),
          style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.primaryColor,
            foregroundColor: Colors.white,
          ),
          onPressed: (){
            _con.selectDate();
          },

        ),
      ],
    );
  }
  Widget _Atras(){
    return GestureDetector(
      onTap: _con.goAtras,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10, top: 10),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 30,
            ),
          ),

        ],
      ),
    );
  }

  Widget _texFieldSerach(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar',
          suffixIcon: const Icon(Icons.search, color: Colors.grey),
          hintStyle: TextStyle(
            fontSize: 17,
            color: Colors.grey.shade500
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
            )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(
                color: Colors.grey.shade400,
              )
          ),
          contentPadding: const EdgeInsets.all(15)
        ),


      ),
    );
  }

  Widget _chatScreen(){
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10),
      child:  const Row(
        children: [
          CircleAvatar(
            backgroundImage:  AssetImage('assets/img/profile.jpg'),
          ),
          SizedBox(width: 10),
          Text('Soporte', style: TextStyle(
              fontWeight: FontWeight.bold,
            fontSize: 20
          ),),
        ],
      ),
    );
  }

  Widget _mensajeSoporte(String mensajeSoporte){
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding:  const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10,),
          Container(
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                mensajeSoporte,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          const SizedBox(height: 5)
        ],
      ),
    );
  }


  Widget _mensajeUser(String mensajeUser){
    return Container(
      padding:  const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 20,),
          Container(
            decoration: BoxDecoration(
                color: Colors.orange, borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                mensajeUser,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          const SizedBox(height: 5)
        ],
      ),
    );
  }

  Widget _MessageFieldBox(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color:MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30),

      ),
      child:  TextField(
        style: const TextStyle( fontSize: 20),
        decoration: InputDecoration(
            hintText: 'Escribe aqui tus comentarios..',
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: MyColors.primaryColorDark
            ),
            prefixIcon: Icon(
              Icons.message,
              color: MyColors.primaryColor,
            )
        ),
      ),
    );
  }

  Widget _hora() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _con.selectedTime != null
              ? '${_con.selectedTime!.format(context)}'
              : '',
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
        IconButton(
          icon: const Icon(Icons.timer),
          style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.primaryColorDark,
          foregroundColor: Colors.white,
          ),
          onPressed: (){
            _con.selectTime();
          },
        ),
      ],
    );
  }

  Widget _AreaEncargada(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color:Colors.white,
        borderRadius: BorderRadius.circular(30),

      ),
      child:  TextField(
        enabled: false,
        controller: _con.txtareencargada,
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            prefixIcon: Icon(
              Icons.area_chart,
              color: MyColors.primaryColor,
            )
        ),
        style: TextStyle( fontSize: 20, color: Colors.orange.shade900),

      ),
    );
  }

  Widget _Prioridad(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color:Colors.white,
        borderRadius: BorderRadius.circular(30),

      ),
      child:  TextField(

         enabled: false,
         controller: _con.txtprioridad,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            prefixIcon: Icon(
              Icons.priority_high,
              color: MyColors.primaryColor,
            )
        ),
        style: TextStyle( fontSize: 20, color: Colors.orange.shade900),
      ),
    );
  }

  Widget _imagen() {
    return GestureDetector(
      onTap: _con.showAlertDialog,
      child: Center(
        child: Container(
          width: 50, // Ancho del cuadrado
          height: 50, // Altura del cuadrado
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20), // Opcional: Bordes redondeados
            image: DecorationImage(
              image: _con.imageFile != null
                  ? FileImage(_con.imageFile!)
                  : const AssetImage('assets/img/no-image.jpg') as ImageProvider,
              fit: BoxFit.cover, // Asegura que la imagen cubra todo el cuadrado
            ),
          ),
        ),
      ),
    );
  }
  String decodeHtml(String htmlText) {
    return parse(htmlText).documentElement?.text ?? htmlText;
  }
  void refresh(){
    setState(() {});
  }
}

