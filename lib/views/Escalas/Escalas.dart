
import 'dart:convert';

import 'package:app_transito/views/Escalas/Widgets/EscalasListWidget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/escala.dart';

class Escalas extends StatefulWidget {
  const Escalas({Key key}) : super(key: key);

  @override
  State<Escalas> createState() => _EscalasState();
}


class _EscalasState extends State<Escalas> {
  Future requisitionEscalas;
  List<Escala> listEscala = <Escala>[];


  @override
  void initState(){
   requisitionEscalas = _loadListEscala();
  }


  Future<List<Escala>> _loadListEscala() async{
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('listEscala');

    if(data != null){
      List<dynamic> jsonObjects = jsonDecode(data);
      return jsonObjects.map((e) => Escala.fromJson(e)).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF28282b),
      body: FutureBuilder(
        future: requisitionEscalas,
          builder: (context, snapshot){
            if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
              listEscala = snapshot.data;
              return Column(
                children: [
                  SizedBox(height: 20),
                  Text("ESCALAS", style: TextStyle(
                      fontFamily: "OpensSans",
                      fontSize: 40,
                      color: Color(0xFFf0821e)
                  )),
                  SizedBox(height: 20),
                  Column(
                   children: List.generate(listEscala.length, (index) {
                     return EscalasListWidget(voluntario: listEscala[index].voluntario, data: listEscala[index].data, hora: listEscala[index].hora);
                   }),
                  ),
                ],
              );
            }else if(!snapshot.hasData && snapshot.connectionState == ConnectionState.done){
              return Center(child: Text("Não possui dados de escalas!!!", style: TextStyle(
                  fontFamily: "OpensSans",
                  fontSize: 20,
                  color: Color(0xFFf0821e)
              ),));
            }else{
              return CircularProgressIndicator();
            }
          }
      )
    );
  }
}


