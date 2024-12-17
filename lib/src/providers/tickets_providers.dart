import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mesadeayuda/src/api/environment.dart';
import 'package:mesadeayuda/src/models/Prioridad.dart';
import 'package:mesadeayuda/src/models/area_servicios.dart';
import 'package:mesadeayuda/src/models/fallas.dart';
import 'package:mesadeayuda/src/models/personal.dart';
import 'package:mesadeayuda/src/models/solicitud_atendio.dart';
import 'package:mesadeayuda/src/models/solicitud_mensaje.dart';
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

  Future<List<TicketDetalle>> consultarTicket(String ticketId) async {
    try {
      List<TicketDetalle> ticket =[];
      String url = '$_url$_api/consultaTiket/$ticketId';
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

  Future<List<TicketsInfo>> consultarTickets(String departamento) async {
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

  Future<List<ArchivosTicket>> consultarArchivos(String idArchivo) async {
    try {
      List<ArchivosTicket> archivos = [];
      String url = '$_url$_api/consultaArchivo/$idArchivo';
      Map<String, dynamic> headers = {
        'Content-type': 'application/json',
      };

      var res = await dio.get(url, options: Options(headers: headers));

      if (res.statusCode == 200) {
        List<dynamic> data = res.data;
        archivos = data.map((item) => ArchivosTicket.fromJson(item)).toList();
      }
      return archivos;
    } catch (e) {
      return [ArchivosTicket(id: 0, archivo: '', archivo_nombre: '', ticket_id: 0, ticket_mensaje_id: 0)];
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

  Future<List<Fallas>> consulTaFallas(String clasificacion) async {
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

  Future<bool> updateTicket(SolicitudAtendio solicitudAtendio) async {
    try{
      String url = '$_url$_api/updateTicket';
      String bodyParams = json.encode(solicitudAtendio.toJson());
      Map<String, dynamic> headers = {
        'Content-type': 'application/json',
      };
      var res = await dio.put(url, data: bodyParams, options: Options(headers: headers));
      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    }catch(e){
      return false;
    }
  }

  Future<bool> crearMensaje(SolicitudMensaje solicitudMensaje) async {
    try{
      String url = '$_url$_api/crearMensaje';
      String bodyParams = json.encode(solicitudMensaje.toJson());
      Map<String, dynamic> headers = {
        'Content-type': 'application/json',
      };
      var res = await dio.post(url, data: bodyParams, options: Options(headers: headers));
      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    }catch(e){
      return false;
    }
  }

  Future<String> consultaareAignada(String clave) async {
    try {
      // Construir la URL con el parámetro
      String url = '$_url$_api/consultaareAignada/$clave';

      // Configurar los encabezados
      Map<String, dynamic> headers = {
        'Content-type': 'application/json',
      };

      // Realizar la solicitud GET
      var res = await dio.get(
        url,
        options: Options(headers: headers),
      );

      // Validar y retornar la respuesta
      if (res.statusCode == 200 && res.data != null && res.data.isNotEmpty) {
        return res.data.toString(); // Asegurar que es un string
      } else {
        return ''; // Respuesta vacía si no hay datos
      }
    } catch (e) {
      // Manejar errores
      print('Error en consultaAreaAsignada: $e');
      return '';
    }
  }


}