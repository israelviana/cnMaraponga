import 'package:app_transito/views/Login/Login.dart';
import 'package:flutter/material.dart';


const String loginRoute = '/login';

class RouterCn{
  mainRoutes(){
    return (RouteSettings setting){
      switch (setting.name){
        case loginRoute:
          return MaterialPageRoute(builder: (_) => Login());
      }
    };
  }
}