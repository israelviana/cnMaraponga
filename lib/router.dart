import 'package:app_transito/views/Login/Cadastro.dart';
import 'package:app_transito/views/Login/EsqueceuSenha.dart';
import 'package:app_transito/views/Login/Login.dart';
import 'package:app_transito/views/Cadastros/CadastroEscalas.dart';
import 'package:app_transito/views/Home/Inicial.dart';
import 'package:app_transito/views/Cadastros/CadastroVeiculos.dart';
import 'package:app_transito/views/Cadastros/CadastroVoluntario.dart';
import 'package:flutter/material.dart';


const String loginRoute = '/login';
const String esqueceuSenhaRoute = '/esqueceuSenha';
const String cadastroRoute = '/cadastro';
const String inicialRoute = '/inicial';
const String cadastroEscalasRoute = '/cadastroEscalas';
const String cadastroVeiculosRoute = '/cadastroVeiculos';
const String cadastroVoluntario = '/cadastroVoluntario';

class RouterCn{
  mainRoutes(){
    return (RouteSettings setting){
      switch (setting.name){
        case loginRoute:
          return MaterialPageRoute(builder: (_) => Login());
        case esqueceuSenhaRoute:
          return MaterialPageRoute(builder: (_) => EsqueceuSenha());
        case cadastroRoute:
          return MaterialPageRoute(builder:  (_) => Cadastro());
        case inicialRoute:
          return MaterialPageRoute(builder: (_) => Inicial());
        case cadastroEscalasRoute:
          return MaterialPageRoute(builder: (_) => CadastroEscalas());
        case cadastroVeiculosRoute:
          return MaterialPageRoute(builder: (_) => CadastroVeiculos());
        case cadastroVoluntario:
          return MaterialPageRoute(builder: (_) => CadastroVoluntario());
      }
    };
  }
}