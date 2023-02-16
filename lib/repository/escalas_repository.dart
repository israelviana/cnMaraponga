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

    List<Map<String, dynamic>> escalas = await db.query('escalas');
    _Escalas = escalas.map((escala) => Escala(id: escala['id'], voluntario:  escala['nome'], data: escala['data'], hora: escala['hora'])).toList();

    notifyListeners();
  }

  setEscalas(String nome, String data, String hora) async{
    db = await DB.instance.database;
    db.insert('escalas', {
      'nome': nome,
      'data': data,
      'hora': hora
    });
    notifyListeners();
  }

}