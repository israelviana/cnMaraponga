import 'package:app_transito/views/Edicao/EditEscalas.dart';
import 'package:app_transito/views/Edicao/EditVeiculos.dart';
import 'package:app_transito/views/Edicao/EditVoluntarios.dart';
import 'package:app_transito/views/Escalas/Escalas.dart';
import 'package:app_transito/views/Login/Cadastro.dart';
import 'package:app_transito/views/Login/EsqueceuSenha.dart';
import 'package:app_transito/views/Login/Login.dart';
import 'package:app_transito/views/Cadastros/CadastroEscalas.dart';
import 'package:app_transito/views/Home/Inicial.dart';
import 'package:app_transito/views/Cadastros/CadastroVeiculos.dart';
import 'package:app_transito/views/Cadastros/CadastroVoluntario.dart';
import 'package:app_transito/views/Veiculos/Veiculos.dart';
import 'package:app_transito/views/Voluntarios/Voluntarios.dart';
import 'package:flutter/material.dart';

//Login
const String loginRoute = '/login';
const String esqueceuSenhaRoute = '/esqueceuSenha';
const String cadastroRoute = '/cadastro';
const String inicialRoute = '/inicial';

//Escalas
const String escalasRoute = '/escalas';
const String cadastroEscalasRoute = '/cadastroEscalas';
const String edicaoEscalaRoute = '/edicaoEscala';

//Veiculos
const String veiculosRoute = '/veiculos';
const String cadastroVeiculosRoute = '/cadastroVeiculos';
const String edicaoVeiculoRoute = '/edicaoVeiculo';

//Voluntarios
const String voluntariosRoute = '/voluntarios';
const String cadastroVoluntarioRoute = '/cadastroVoluntario';
const String edicaoVoluntarioRoute = '/edicaoVoluntario';



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
        case cadastroVoluntarioRoute:
          return MaterialPageRoute(builder: (_) => CadastroVoluntario());
        case escalasRoute:
          return MaterialPageRoute(builder: (_) => Escalas());
        case veiculosRoute:
          return MaterialPageRoute(builder: (_) => Veiculos());
        case voluntariosRoute:
          return MaterialPageRoute(builder: (_) => Voluntarios());
        case edicaoVeiculoRoute:
          String id = setting.arguments;
          return MaterialPageRoute(builder: (_) => EditVeiculos(id: id));
        case edicaoEscalaRoute:
          String id = setting.arguments;
          return MaterialPageRoute(builder: (_) => EditEscalas(id: id));
        case edicaoVoluntarioRoute:
          String id = setting.arguments;
          return MaterialPageRoute(builder: (_) => EditVoluntario(id: id));
      }
    };
  }
}