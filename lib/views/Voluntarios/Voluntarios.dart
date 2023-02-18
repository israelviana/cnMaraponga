import 'dart:convert';

import 'package:app_transito/models/voluntario.dart';
import 'package:app_transito/views/Voluntarios/Widgets/VoluntariosList.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../../components/inputForm.dart';

class Voluntarios extends StatefulWidget {
  const Voluntarios({Key key}) : super(key: key);

  @override
  State<Voluntarios> createState() => _VoluntariosState();
}

class _VoluntariosState extends State<Voluntarios> {

  List<Voluntario> listaVoluntarios = [];


  Future requisitionVoluntario;


  final cpfController = TextEditingController(text: '');

  String cpf;

  @override
  void initState(){
    _carregarVoluntarios();
    cpfController.text = "";
  }


  _carregarVoluntarios() async{
    final database = await openDatabase('cnMaraponga.db');

    List<Map<String, dynamic>> voluntarios = await database.query('voluntarios');

    setState(() {
      listaVoluntarios = voluntarios.map((voluntario) => Voluntario(telefone: voluntario['telefone'], nome: voluntario['nome'], cpf: voluntario['cpf'])).toList();
    });

    database.close();
  }

  _buscarCpf(String cpf) async{
    final database = await openDatabase('cnMaraponga.db');

    List<Map<String, dynamic>> voluntarios = await database.query('voluntarios',where: '"cpf" = ?', whereArgs: ['$cpf']);

    setState(() {
      listaVoluntarios = voluntarios.map((voluntario) => Voluntario(telefone: voluntario['telefone'], nome: voluntario['nome'], cpf: voluntario['cpf'])).toList();
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
            slivers: [
              SliverList(
                  delegate: SliverChildListDelegate([
                    Column(
                      children: [
                        Text("VOLUNTÁRIOS", style: TextStyle(
                            fontFamily: "OpensSans",
                            fontSize: 40,
                            color: Color(0xFFf0821e)
                        )),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Flexible(child: InputForm(title: 'Digite o CPF pelo qual deseja buscar', mask: "CPF", type: "TEXT", controller: cpfController,)),
                              InkWell(
                                onTap: (){
                                  cpf = cpfController.text;
                                  if(cpf == ""){
                                    initState();
                                  }else{
                                    _buscarCpf(cpf);
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
                        listaVoluntarios.length == 0 ?
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Center(child: Text("Não possui dados de voluntarios!!!", style: TextStyle(
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
                              itemCount: listaVoluntarios.length,
                              itemBuilder: (BuildContext context, int index){
                                return VoluntariosList(nome: listaVoluntarios[index].nome, cpf: listaVoluntarios[index].cpf, telefone: listaVoluntarios[index].telefone);
                          }),
                        )
                      ])
            ])
              )
            ],
          ),
        )
      ),
    );
  }
}
