import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:mesadeayuda/src/page/login/login_controller.dart';
import 'package:mesadeayuda/src/utils/my_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController _con = LoginController();

  @override
  void initState(){
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: -80,
                left: -100,
                child: _circleLogin()),
            Positioned(
             top: 60,
              left: 25,
              child: _textLogin(),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  _lottieAnimation(),
                  //_imageBanner(),
                  _textFieldEmail(),
                  _textFieldPassword(),
                  _buttonLogin(),

                ],
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget _textLogin(){
    return const Text(
        'Mesa de Ayuda',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 22,
        fontFamily: 'NimbusSans'
      ),
    );
  }

  Widget _circleLogin(){
    return Container(
      width: 290,
      height: 230,
      decoration: BoxDecoration( 
        borderRadius: BorderRadius.circular(90),
        color: MyColors.primaryColor
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
       width: 200,
       height: 200,
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

  Widget _textFieldEmail(){
   return Container(
     margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),

     child:  Container(

       decoration: BoxDecoration(
         color: Colors.orange.shade100,
         borderRadius: BorderRadius.circular(30),
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

  Widget _textFieldPassword(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.orange.shade100,
        borderRadius: BorderRadius.circular(30),
      ),
      child:  TextField(
        controller: _con.passwordController,
        obscureText: true,
        decoration: const InputDecoration(
            hintText: 'Contraseña',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: Colors.red,
                 fontSize: 15
            ),
            prefixIcon: Icon(
              Icons.lock_outline,
              color: Colors.black,
            ),

        ),
         style: TextStyle( fontSize: 15, color: Colors.black),
      ),
    );
  }

  Widget _buttonLogin(){
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),

      child: ElevatedButton(
          onPressed: _con.login,
      style: ElevatedButton.styleFrom(
      backgroundColor: Colors.red.shade900,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30)),
        padding: EdgeInsets.symmetric(vertical: 15)
      ),
          child:  const Text('Ingresar', style: TextStyle(
            fontSize: 15
          ),),

      ),
    );
  }



}
