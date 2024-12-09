import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mesadeayuda/src/api/environment.dart';
import 'package:mesadeayuda/src/models/Tickets.dart';
import 'package:mesadeayuda/src/models/personal.dart';
import 'package:mesadeayuda/src/models/user_login.dart';



class TicketsProviders {
  Dio dio = Dio();

  final String _url = Environment.API_MESA_DE_AYUDA;
  final String _api = "api/tickets";
  late BuildContext context;

  Future<void> init(BuildContext context) async {
    this.context= context;
  }

  Future<List<Tickets>> consultarTickets() async {
    try {
      List<Tickets> tickets = [];
      String url = '$_url$_api/consultaTikets';
      Map<String, dynamic> headers = {
        'Content-type': 'application/json',
      };
      var res = await dio.get(url, options: Options(headers: headers));

      if(res.statusCode == 200){
       List<dynamic> data = res.data;
       tickets = data.map((item) => Tickets.fromJson(item)).toList();
     }
     return tickets;
    } catch (e) {
      return [];
    }
  }

  Future<List<Personal>> consulTaPersonal(String departamento) async {
    try {
      List<Personal> personal = [];
      String url = '$_url$_api/personal/$departamento';
      Map<String, dynamic> headers = {
        'Content-type': 'application/json',
      };
      var res = await dio.get(url, options: Options(headers: headers));

      if(res.statusCode == 200){
        List<dynamic> data = res.data;
        personal = data.map((item) => Personal.fromJson(item)).toList();
      }
      return personal;
    } catch (e) {
      return [];
    }
  }

}