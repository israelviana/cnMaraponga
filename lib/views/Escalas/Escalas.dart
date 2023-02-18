
import 'dart:convert';

import 'package:app_transito/views/Escalas/Widgets/EscalasListWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../../components/inputForm.dart';
import '../../models/escala.dart';
import '../../repository/escalas_repository.dart';

class Escalas extends StatefulWidget {
  const Escalas({Key key}) : super(key: key);

  @override
  State<Escalas> createState() => _EscalasState();
}


class _EscalasState extends State<Escalas> {
  Future requisitionEscalas;
  List<Escala> listEscala = <Escala>[];

  final nomeController = TextEditingController(text: '');
  String nome;


  @override
  void initState(){
    _carregarEscalas();
    nomeController.text = "";
  }


  void _carregarEscalas() async{
    final database = await openDatabase('cnMaraponga.db');
    List<Map<String, dynamic>> escalas = await database.query('escalas');
    setState(() {
      listEscala = escalas.map((escala) => Escala(id: escala['id'], voluntario:  escala['nome'], data: escala['data'], hora: escala['hora'])).toList();
    });
    database.close();
  }

  _buscarVoluntario(String nome) async{
    final database = await openDatabase('cnMaraponga.db');
    List<Map<String, dynamic>> escalas = await database.query('escalas', where: '"nome" = ?', whereArgs: ['$nome']);
    setState(() {
      listEscala = escalas.map((escala) => Escala(id: escala['id'], voluntario:  escala['nome'], data: escala['data'], hora: escala['hora'])).toList();
    });
    database.close();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF28282b),
        body: RefreshIndicator(
          onRefresh: () => Future.delayed(Duration(milliseconds: 500), () => initState()),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                  delegate: SliverChildListDelegate([
                    Column(
                      children: [
                        SizedBox(height: 20),
                        Text("ESCALAS", style: TextStyle(
                            fontFamily: "OpensSans",
                            fontSize: 40,
                            color: Color(0xFFf0821e)
                        )),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Flexible(child: InputForm(title: 'Digite o VOLUNTARIO pelo qual deseja buscar', type: "TEXT", controller: nomeController)),
                              InkWell(
                                onTap: (){
                                  nome = nomeController.text;
                                  if(nome == ""){
                                    initState();
                                  }else{
                                    _buscarVoluntario(nome);
                                  }
                                },
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFf0821e)
                                  ),
                                  child: Icon(Icons.search),
                                ),
                              )
                            ],
                          ),
                        ),
                        listEscala.length == 0 ? Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Center(child: Text("Não possui dados de escalas!!!", style: TextStyle(
                              fontFamily: "OpensSans",
                              fontSize: 20,
                              color: Color(0xFFf0821e)
                          ))),
                        ) :
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: listEscala.length,
                              itemBuilder: (BuildContext context, int index){
                                return EscalasListWidget(voluntario: listEscala[index].voluntario, data: listEscala[index].data, hora: listEscala[index].hora);
                              }
                          ),
                        ),
                      ],
                    ),
                  ]))
            ],
          ),
        ),
        )
      );
  }
}


