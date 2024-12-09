import 'package:flutter/material.dart';
import 'package:mesadeayuda/src/utils/my_colors.dart';

class MySnackBar{
  static void show(BuildContext context, String text){
    if(context == null) return;

    FocusScope.of(context).requestFocus(new FocusNode());
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
        new SnackBar(
        content: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20
          ),
        ),
          backgroundColor: MyColors.primaryColorDark,
          duration: const Duration(seconds: 3),
    )
    );
  }
}