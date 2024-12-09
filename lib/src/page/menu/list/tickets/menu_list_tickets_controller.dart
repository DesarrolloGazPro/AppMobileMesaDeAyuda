
import 'package:flutter/material.dart';
import 'package:mesadeayuda/src/models/user_respuesta_login.dart';
import 'package:mesadeayuda/src/utils/shared_pref.dart';

class MenuListTicketsController { 
  late BuildContext context;
  SharedPref _sharedPref = new SharedPref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  late Function refresh;

  late UserRespuestaLogin userLogin;
  Future<void> init(BuildContext context, Function refresh) async {
     this.context=context;
     this.refresh=refresh;
     userLogin = UserRespuestaLogin.fromJson( await _sharedPref.read('userLogin'));
     refresh();
  }
  void logout(){
  _sharedPref.logout(context);
  }

  void gotoUpdateTicketPage(){
    Navigator.pushNamed(context, 'menu/list/update');
  }

  void openDrawer(){
   key.currentState?.openDrawer();
  }
}