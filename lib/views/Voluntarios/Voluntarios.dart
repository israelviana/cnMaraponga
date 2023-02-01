import 'dart:convert';

import 'package:app_transito/models/voluntario.dart';
import 'package:app_transito/views/Voluntarios/Widgets/VoluntariosList.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Voluntarios extends StatefulWidget {
  const Voluntarios({Key key}) : super(key: key);

  @override
  State<Voluntarios> createState() => _VoluntariosState();
}

class _VoluntariosState extends State<Voluntarios> {

  List<Voluntario> listaVoluntarios = [];


  Future requisitionVoluntario;


  @override
  void initState(){
    requisitionVoluntario = loadVoluntarioList();
  }

  Future<List<Voluntario>> loadVoluntarioList() async{
    final prefs = await SharedPreferences.getInstance();
    final listVoluntarioJson =  prefs.getString("keyVoluntario");

    if(listVoluntarioJson != null){
      List<dynamic> listVoluntario = jsonDecode(listVoluntarioJson);
      return listVoluntario.map((e) => Voluntario.fromJson(e)).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF28282b),
      body: FutureBuilder(
        future: requisitionVoluntario,
        builder: (context, snapshot){
          if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
            listaVoluntarios = snapshot.data;
            return Column(
              children: [
                Text("VOLUNTÁRIOS", style: TextStyle(
                    fontFamily: "OpensSans",
                    fontSize: 40,
                    color: Color(0xFFf0821e)
                )),
                SizedBox(height: 20),
                Column(
                  children: List.generate(listaVoluntarios.length, (index) {
                    return VoluntariosList(nome: listaVoluntarios[index].nome, cpf: listaVoluntarios[index].cpf, telefone: listaVoluntarios[index].telefone);
                  }),
                )
              ],
            );
          }else if(!snapshot.hasData && snapshot.connectionState == ConnectionState.done){
            return Center(child: Text("Não possui dados de voluntarios!!!", style: TextStyle(
                fontFamily: "OpensSans",
                fontSize: 20,
                color: Color(0xFFf0821e)
            ),));
          }else{
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
