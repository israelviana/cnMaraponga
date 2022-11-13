import 'package:app_transito/views/Login/EsqueceuSenha.dart';
import 'package:app_transito/views/Login/Login.dart';
import 'package:flutter/material.dart';


const String loginRoute = '/login';
const String esqueceuSenhaRoute = '/esqueceuSenha';

class RouterCn{
  mainRoutes(){
    return (RouteSettings setting){
      switch (setting.name){
        case loginRoute:
          return MaterialPageRoute(builder: (_) => Login());
        case esqueceuSenhaRoute:
          return MaterialPageRoute(builder: (_) => EsqueceuSenha());
      }
    };
  }
}