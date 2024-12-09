

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mesadeayuda/src/page/menu/list/update/tickets_update_controller.dart';
import 'package:mesadeayuda/src/page/register/register_controller.dart';

import '../../../../utils/my_colors.dart';


class TicketsUpdatePage extends StatefulWidget {
  const TicketsUpdatePage({super.key});

  @override
  State<TicketsUpdatePage> createState() => _TicketsUpdatePage();
}

class _TicketsUpdatePage extends State<TicketsUpdatePage> {
  final TicketsUpdateController _con=  TicketsUpdateController();

  @override
  void initState(){
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar( 
         title: Text('Editar perfil'),
       ),
       
        body: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50),
                _imageUser(),
                const SizedBox(height: 30),

                _textFieldName(),
                _textFieldLastname(),
                _textFieldPhone(),
              ],
            ),
          ),
        ),
      bottomNavigationBar: _buttonRegister(),
    );
  }

  ImageProvider<Object> _getImageProvider() {
    try {
      if (_con.userLogin.usuarios?.image != null && _con.userLogin.usuarios!.image!.isNotEmpty) {
        String base64Image = _con.userLogin.usuarios!.image!;
        if (base64Image.contains(',')) {
          base64Image = base64Image.split(',').last;
        }
        // Asegurar que la longitud sea válida (múltiplo de 4)
        while (base64Image.length % 4 != 0) {
          base64Image += '=';
        }

        // Decodificar la imagen
        var imageBytes = base64Decode(base64Image);
        return MemoryImage(imageBytes);
      }
    } catch (e) {
    }    // Si no hay imagen o ocurre un error, retorna la imagen predeterminada
    return const AssetImage('assets/img/user_profile_2.png');
  }


  Widget _imageUser(){
    return GestureDetector(
      onTap: _con.showAlertDialog ,
      child: CircleAvatar(
        backgroundImage: _getImageProvider(),
        radius: 50,
        backgroundColor: Colors.grey.shade200,
      ),
    );
  }

  Widget _iconBack(){
    return IconButton(
        onPressed: _con.back,
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white,)

    );
  }

  Widget _textRegister(){
    return const Text(
      'Registro',
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: 'NimbusSans'
      ),
    );
  }

  Widget _circleLogin(){
    return Container(
      width: 240,
      height: 230,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: MyColors.primaryColor
      ),
    );
  }



  Widget _textFieldName(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color:MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30),

      ),
      child:  TextField(
        controller: _con.nameController,
        decoration: InputDecoration(
            hintText: 'Nombre',
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: MyColors.primaryColorDark
            ),
            prefixIcon: Icon(
              Icons.person_outline,
              color: MyColors.primaryColor,
            )
        ),
      ),
    );
  }

  Widget _textFieldLastname(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color:MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30),

      ),
      child:  TextField(
        controller: _con.lastNameController,
        decoration: InputDecoration(
            hintText: 'Appellido',
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: MyColors.primaryColorDark
            ),
            prefixIcon: Icon(
              Icons.person,
              color: MyColors.primaryColor,
            )
        ),
      ),
    );
  }

  Widget _textFieldPhone(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color:MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30),

      ),
      child:  TextField(
        keyboardType: TextInputType.phone ,
        controller: _con.phoneController,
        decoration: InputDecoration(
            hintText: 'Telefono',
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: MyColors.primaryColorDark
            ),
            prefixIcon: Icon(
              Icons.phone,
              color: MyColors.primaryColor,
            )
        ),
      ),
    );
  }





  Widget _buttonRegister(){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: _con.isEnable ? _con.register : null,
        style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.symmetric(vertical: 15)
        ),
        child:  const Text('Actulizar'),

      ),
    );
  }

  void refresh(){
    setState(() {

    });
  }
}
