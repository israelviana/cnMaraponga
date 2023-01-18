import 'package:flutter/material.dart';

class ScalffoldMensage{
  static void messageSucessLogin(String name, key){
    key.currentState.showSnackBar(
      SnackBar(
        dismissDirection: DismissDirection.down,
        elevation: 5,
        behavior: SnackBarBehavior.floating,
        content: Text(name),
        backgroundColor: Color(0xFF4FBD2D),
      ),
    );
  }

  static void messageErrorLogin(String name, key) async{
    key.currentState.showSnackBar(
      SnackBar(
        dismissDirection: DismissDirection.down,
        elevation: 5,
        behavior: SnackBarBehavior.floating,
        content: Text(name),
        backgroundColor: Color(0xFFF0423A),
      ),
    );
  }

}