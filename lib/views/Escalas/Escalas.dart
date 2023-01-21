
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



  @override
  void initState(){
   requisitionEscalas = loadEscalaList();
  }


  Future<List<Escala>> loadEscalaList() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getEscalaList("listEscala");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF28282b),
      body: FutureBuilder(
        future: requisitionEscalas,
          builder: (context, snapshot){
            if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
              List<Escala> escala = <Escala>[];
              escala = snapshot.data;
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
                   children: List.generate(escala.length, (index) {
                     return EscalasListWidget(voluntario: escala[index].voluntario, data: escala[index].data, hora: escala[index].hora);
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


