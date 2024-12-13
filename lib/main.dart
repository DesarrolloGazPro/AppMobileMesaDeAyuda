import 'package:flutter/material.dart';
import 'package:mesadeayuda/src/page/login/login_page.dart';
import 'package:mesadeayuda/src/page/menu/list/tickets/menu_list_tickets_page.dart';
import 'package:mesadeayuda/src/page/menu/list/update/tickets_update_page.dart';
import 'package:mesadeayuda/src/page/menu/tickets/list/list_tickets_page.dart';
import 'package:mesadeayuda/src/page/register/register_page.dart';
import 'package:mesadeayuda/src/utils/my_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Mesa de Ayuda',
      color: MyColors.primaryColor,
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login' : (BuildContext context) => const LoginPage(),
        'register' : (BuildContext context) => const RegisterPage(),
        'menu/list/tickets' : (BuildContext context) => const MenuListTicketsPage(),
        'menu/list/update' : (BuildContext context) => const TicketsUpdatePage(),
        'menu/tickets/list' : (BuildContext context) => const ListTicketsPage(),

      },
      theme: ThemeData(
        primaryColor: Colors.red,
        //fontFamily: 'NimbusSans',
        appBarTheme: AppBarTheme(
          backgroundColor: MyColors.primaryColor,
          elevation: 0,
        )
      )
    );
  }
}

