import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mesadeayuda/src/api/environment.dart';
import 'package:mesadeayuda/src/models/Prioridad.dart';
import 'package:mesadeayuda/src/models/area_servicios.dart';
import 'package:mesadeayuda/src/models/fallas.dart';
import 'package:mesadeayuda/src/models/personal.dart';
import '../models/TicketsInfo.dart';
import '../models/ticket_detalle.dart';

class TicketsProviders {
  Dio dio = Dio();

  final String _url = Environment.API_MESA_DE_AYUDA;
  final String _api = "api/tickets";
  late BuildContext context;

  Future<void> init(BuildContext context) async {
    this.context= context;
  }

  Future<List<TicketDetalle>> consultarTicket(String clave, String ticketId) async {
    try {
      List<TicketDetalle> ticket =[];
      String url = '$_url$_api/consultaTiket/$clave/$ticketId';
      Map<String, dynamic> headers = {
        'Content-type': 'application/json',
      };
      var res = await dio.get(url, options: Options(headers: headers));

      if(res.statusCode == 200){
        dynamic data = res.data;
        var ticketsList = List<Ticket>.from(data['tickets'].map((item) => Ticket.fromJson(item)));
        var ticketsMensajesList = List<TicketsMensaje>.from(data['ticketsMensajes'].map((item) => TicketsMensaje.fromJson(item)));
        var archivosTicketsList = List<ArchivosTicket>.from(data['archivosTickets'].map((item) => ArchivosTicket.fromJson(item)));

        ticket = [
          TicketDetalle(
              tickets: ticketsList,
              ticketsMensajes: ticketsMensajesList,
              archivosTickets: archivosTicketsList
          )
        ];
      }
      return ticket;
    } catch (e) {
      return [];
    }
  }

  Future<List<TicketsInfo>> consultarTickets(departamento) async {
    try {
      List<TicketsInfo> tickets = [];
      String url = '$_url$_api/consultaTikets/$departamento';
      Map<String, dynamic> headers = {
        'Content-type': 'application/json',
      };
      var res = await dio.get(url, options: Options(headers: headers));

      if(res.statusCode == 200){
       List<dynamic> data = res.data;
       tickets = data.map((item) => TicketsInfo.fromJson(item)).toList();
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

  Future<List<AreaServicios>> consulTaArea() async {
    try {
      List<AreaServicios> area = [];
      String url = '$_url$_api/area';
      Map<String, dynamic> headers = {
        'Content-type': 'application/json',
      };
      var res = await dio.get(url, options: Options(headers: headers));

      if(res.statusCode == 200){
        List<dynamic> data = res.data;
        area = data.map((item) => AreaServicios.fromJson(item)).toList();
      }
      return area;
    } catch (e) {
      return [];
    }
  }

  Future<List<Fallas>> consulTaFallas(int clasificacion) async {
    try {
      List<Fallas> fallas = [];
      String url = '$_url$_api/fallas/$clasificacion';
      Map<String, dynamic> headers = {
        'Content-type': 'application/json',
      };
      var res = await dio.get(url, options: Options(headers: headers));

      if(res.statusCode == 200){
        List<dynamic> data = res.data;
        fallas = data.map((item) => Fallas.fromJson(item)).toList();
      }
      return fallas;
    } catch (e) {
      return [];
    }
  }

  Future<List<Prioridad>> consulTaPrioridades() async {
    try {
      List<Prioridad> prioridades = [];
      String url = '$_url$_api/prioridades';
      Map<String, dynamic> headers = {
        'Content-type': 'application/json',
      };
      var res = await dio.get(url, options: Options(headers: headers));

      if(res.statusCode == 200){
        List<dynamic> data = res.data;
        prioridades = data.map((item) => Prioridad.fromJson(item)).toList();
      }
      return prioridades;
    } catch (e) {
      return [];
    }
  }

}