import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:mesadeayuda/src/page/login/login_controller.dart';
import 'package:mesadeayuda/src/utils/my_colors.dart';

class LoginPage extends StatefulWidget {
  String origen;

      LoginPage({Key? key,
      required this.origen,
      }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController _con = LoginController();


  @override
  void initState(){
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, widget.origen);
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color:  const Color.fromARGB(255, 42, 40, 40),
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [

            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                

                children: [
                  _lottieAnimation(),
                  _textMesadeayuda(),
                  const SizedBox(height: 50),
                  //_imageBanner(),
                  _textFieldUser(),
                  const SizedBox(height: 20),
                  _textFieldPassword(),
                  _buttonLogin(),
                   const SizedBox(height: 50),
                  Text( 'GAZPRO@ Derechos reservados ${DateTime.now().year}', style: TextStyle( color: Colors.white, fontFamily: 'NimbusSans', ), ),                  const SizedBox(height: 20),

                ],
              ),
            ),
          ],
        ),
      ),

    );
  }

  Widget _textMesadeayuda(){
    return const Text(
      'MESA DE AYUDA',
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 40,
          fontFamily: 'Roboto'
      ),
    );
  }

  Widget _textLogin(){
    return const Text(
        'Mesa de Ayuda',
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 22,
       
      ),
    );
  }

  Widget _circleLogin(){
    return Container(
      width: 290,
      height: 230,
      decoration: BoxDecoration( 
        borderRadius: BorderRadius.circular(90),
        color: Colors.white
      ),
    );
  }

  Widget _circle(){
    return Container(
      width: 250,
      height: 230,
      decoration: BoxDecoration(
          borderRadius:  BorderRadius.circular(30),
          color: Colors.orange.shade900
      ),
    );
  }

  Widget _lottieAnimation(){
   return Container(
     margin: EdgeInsets.only(
       top: 150,
       bottom: MediaQuery.of(context).size.height * 0.10,
     ),
     child: Lottie.asset( 'assets/json/soporte.json',
       width: 150,
       height: 150,
       fit: BoxFit.fill


     ),
   );
  }

  Widget _imageBanner(){
   return  Container(
     margin: EdgeInsets.only(
         top: 100,
         bottom: MediaQuery.of(context).size.height * 0.22,
     ),
     child: Image.asset('assets/img/waze.png',
       width: 200,
       height: 200,
     ),
   );
  }

  Widget _textFieldUser(){
   return Container(
     height: 50,
     margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),

     child:  Container(
       decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.circular(5),
       ),
       child: TextField(

         controller: _con.userNameController,
         keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: 'Id Empleado',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
              color: Colors.red,
              fontSize: 15
            ),
            prefixIcon: Icon(
              Icons.email,
              color: Colors.black,
            )
          ),
         style: TextStyle( fontSize: 15, color: Colors.black),
        ),
     ),
   );
  }

  Widget _textFieldPassword() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        controller: _con.passwordController,
        obscureText: _con.isPasswordObscured,
        decoration: InputDecoration(
          hintText: 'Contraseña',
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(15),
          hintStyle: const TextStyle(
            color: Colors.red,
            fontSize: 15,
          ),
          prefixIcon: const Icon(
            Icons.lock_outline,
            color: Colors.black,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _con.isPasswordObscured ? Icons.visibility_off_outlined : Icons.visibility_off_rounded,
              color: Colors.orange,
            ),
            onPressed: () {
              setState(() {
                _con.isPasswordObscured = !_con.isPasswordObscured;
              });
            },
          ),
        ),
        style: const TextStyle(fontSize: 15, color: Colors.black),
      ),
    );
  }

  Widget _buttonLogin(){
    return Container(
      height: 60,
      width: 200,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),

      child: ElevatedButton(
          onPressed: _con.login,
      style: ElevatedButton.styleFrom(
      backgroundColor: Colors.orange.shade800,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(vertical: 15)
      ),
          child:  const Text('INGRESAR', style: TextStyle(
            fontSize: 25,
            fontFamily: 'Roboto'
           
          ),),

      ),
    );
  }



}
