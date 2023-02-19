import 'package:app_transito/views/Registers/Scales.dart';
import 'package:app_transito/views/Registers/Vehicles.dart';
import 'package:app_transito/views/Registers/Volunteers.dart';
import 'package:app_transito/views/Edits/Scales.dart';
import 'package:app_transito/views/Edits/Vehicles.dart';
import 'package:app_transito/views/Edits/Volunteers.dart';
import 'package:app_transito/views/Scales/Scales.dart';
import 'package:app_transito/views/Home/Initial.dart';
import 'package:app_transito/views/Login/Register.dart';
import 'package:app_transito/views/Login/Login.dart';
import 'package:app_transito/views/Vehicles/Vehicles.dart';
import 'package:app_transito/views/Volunteers/Volunteers.dart';
import 'package:flutter/material.dart';

//Login
const String loginRoute = '/login';
const String forgetPasswordRoute = '/forgetPassoword';
const String registerRoute = '/register';
const String initialRoute = '/initial';

//Scales
const String scalesRoute = '/scales';
const String registerScalesRoute = '/registerScales';
const String editScalesRoute = '/editScales';

//Vehicles
const String vehiclesRoute = '/vehicles';
const String registerVehiclesRoute = '/registerVehicles';
const String editVehiclesRoute = '/editVehicles';

//Volunteers
const String volunteersRoute = '/volunteers';
const String registerVolunteersRoute = '/registerVolunteers';
const String editVolunteersRoute = '/editVolunteers';



class RouterCn{
  mainRoutes(){
    return (RouteSettings setting){
      switch (setting.name){
        case loginRoute:
          return MaterialPageRoute(builder: (_) => Login());
        case registerRoute:
          return MaterialPageRoute(builder:  (_) => Register());
        case initialRoute:
          return MaterialPageRoute(builder: (_) => Initial());
        case registerScalesRoute:
          return MaterialPageRoute(builder: (_) => RegisterScales());
        case registerVehiclesRoute:
          return MaterialPageRoute(builder: (_) => RegisterVehicles());
        case registerVolunteersRoute:
          return MaterialPageRoute(builder: (_) => RegisterVolunteers());
        case scalesRoute:
          return MaterialPageRoute(builder: (_) => Scales());
        case vehiclesRoute:
          return MaterialPageRoute(builder: (_) => Vehicles());
        case volunteersRoute:
          return MaterialPageRoute(builder: (_) => Volunteers());
        case editVehiclesRoute:
          String id = setting.arguments;
          return MaterialPageRoute(builder: (_) => EditVehicles(id: id));
        case editScalesRoute:
          String id = setting.arguments;
          return MaterialPageRoute(builder: (_) => EditScales(id: id));
        case editVolunteersRoute:
          String id = setting.arguments;
          return MaterialPageRoute(builder: (_) => EditVolunteers(id: id));
      }
    };
  }
}