
import 'package:flutter/material.dart';
import 'package:mesadeayuda/src/models/user_login.dart';
import 'package:mesadeayuda/src/models/user_respuesta_login.dart';
import 'package:mesadeayuda/src/models/usuario.dart';
import 'package:mesadeayuda/src/providers/users_provider.dart';
import 'package:mesadeayuda/src/utils/my_snackbar.dart';
import 'package:mesadeayuda/src/utils/shared_pref.dart';
import 'package:sn_progress_dialog/enums/value_position.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class LoginController {
  late BuildContext context;

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController =  TextEditingController();
  UsersProviders usersProviders = new UsersProviders();
  SharedPref _sharedPref  = new SharedPref();
  late ProgressDialog _progressDialog;
  bool isPasswordObscured = true;
  String origenD='';
  Future<void> init(BuildContext context, String origen ) async {
     this.context=context;

     await usersProviders.init(context);
     _progressDialog=ProgressDialog(context: context);

     UserRespuestaLogin login=
            UserRespuestaLogin.fromJson( await _sharedPref.read('userLogin') ?? {});

     if(origen=="menu"){
       userNameController.text = login.usuarios!.empleadoID.toString();
       passwordController.text = login.usuarios!.contrasena;
       return;
     }
     else {
     if(login.token != null){
       if (context.mounted) {
         Navigator.pushNamedAndRemoveUntil(context, 'menu/tickets/list', (route) => false);
       }
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

    if(userName=='' || password==''){
      MySnackBar.show(context, 'Capture sus credenciales de acceso');
      return;
    }

    _progressDialog.show(max: 100, msg: 'Espera un momento...' ,
        backgroundColor: Colors.white , msgColor: Colors.black,
        progressBgColor: Colors.black,  msgTextAlign: TextAlign.center,
        msgFontWeight: FontWeight.bold, msgFontSize: 15,
        valuePosition: ValuePosition.center  );



      Usuario  res = await usersProviders.login(user);
    if (res.token != null && res.token !=''){
      _progressDialog.close();
        _sharedPref.save('userLogin', res.toJson());
        Navigator.pushNamedAndRemoveUntil(context, 'menu/tickets/list', (route) =>false);
    }else{
      _progressDialog.close();
      MySnackBar.show(context, 'Credenciales incorrectas');
    }
  }

}