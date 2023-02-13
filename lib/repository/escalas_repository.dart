import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../database/db.dart';
import '../models/escala.dart';

class EscalasRepository extends ChangeNotifier {
  Database db;

  List<Escala> _Escalas = [];

  List<Escala> get escala => _Escalas;


  EscalasRepository(){
    _initRepository();
  }

  _initRepository() async{
    await _getEscalas();
  }

  _getEscalas() async{
    db = await DB.instance.database;

    List escalas = await db.query('escalas');
    notifyListeners();
  }

}