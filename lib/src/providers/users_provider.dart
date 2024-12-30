import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mesadeayuda/src/api/environment.dart';
import 'package:mesadeayuda/src/models/user.dart';
import 'package:mesadeayuda/src/models/user_login.dart';
import '../models/usuario.dart';


class UsersProviders {
  Dio dio = Dio();

  final String _url = Environment.API_MESA_DE_AYUDA;
  final String _api = "api/user";
  late BuildContext context;

  Future<void> init(BuildContext context) async {
    this.context= context;
  }

  Future<bool> create(User user, File image) async {
    try{
      String url = '$_url$_api/create';
      String? imageBase64;
      if (image != null) {
        final bytes = await image.readAsBytes();
        imageBase64 = base64Encode(bytes);
        user.image=imageBase64;
      }
      String bodyParams = json.encode(user.toJson());
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
  Future<bool> creates(User user) async {
    try {
      String url = '$_url$_api/create';
      String bodyParams = json.encode(user.toJson());
      Map<String, dynamic> headers = {
        'Content-type': 'application/json',
      };
      var res = await dio.post(url, data: bodyParams, options: Options(headers: headers));

      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<Usuario> login(UserLogin user) async {
    try {
      String url = '$_url$_api/login';
      String bodyParams = json.encode(user.toJson());
      Map<String, dynamic> headers = {
        'Content-type': 'application/json',
      };
      var res = await dio.post(
            url, data: bodyParams, options: Options(headers: headers));

     return Usuario.fromJson(res.data);
    } catch (e) {
      return Usuario( );
    }
  }

}