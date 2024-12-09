
import 'package:flutter/material.dart';
import 'package:mesadeayuda/src/models/user_login.dart';
import 'package:mesadeayuda/src/models/user_respuesta_login.dart';
import 'package:mesadeayuda/src/models/usuario.dart';
import 'package:mesadeayuda/src/providers/users_provider.dart';
import 'package:mesadeayuda/src/utils/my_snackbar.dart';
import 'package:mesadeayuda/src/utils/shared_pref.dart';

class LoginController {
  late BuildContext context;

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController =  TextEditingController();
  UsersProviders usersProviders = new UsersProviders();
  SharedPref _sharedPref  = new SharedPref();


  Future<void> init(BuildContext context) async {
     this.context=context;
     await usersProviders.init(context);
     UserRespuestaLogin login=
            UserRespuestaLogin.fromJson( await _sharedPref.read('userLogin') ?? {});

     if(login.token != null){
       if (context.mounted) {
         Navigator.pushNamedAndRemoveUntil(context, 'menu/tickets', (route) => false);
       }
     }
  }

  void gotToRegisterPage(){
    Navigator.pushNamed(context, 'register');
  }

  void login() async {
    String userName= userNameController.text.trim();
    String password = passwordController.text.trim();

    UserLogin user = new UserLogin(
        usuario: userName,
        contrasena: password
    );

      Usuario  res = await usersProviders.login(user);
    if (res.token != null){
        _sharedPref.save('userLogin', res.toJson());
        Navigator.pushNamedAndRemoveUntil(context, 'menu/tickets/list', (route) =>false);
    }else{
      MySnackBar.show(context, 'Credenciales incorrectas');
    }
  }

}