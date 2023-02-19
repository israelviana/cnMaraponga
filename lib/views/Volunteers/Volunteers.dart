import 'dart:convert';

import 'package:app_transito/models/Volunteers.dart';
import 'package:app_transito/router.dart';
import 'package:app_transito/views/Volunteers/Widgets/VoluntariosList.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../../components/inputForm.dart';
import '../../database/db.dart';

enum typeModal{
  modal
}

class Volunteers extends StatefulWidget {
  const Volunteers({Key key}) : super(key: key);

  @override
  State<Volunteers> createState() => _VolunteersState();
}

class _VolunteersState extends State<Volunteers> {

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
    final database = await DB.instance.database;

    List<Map<String, dynamic>> voluntarios = await database.query('voluntarios');

    setState(() {
      listaVoluntarios = voluntarios.map((voluntario) => Voluntario(id: voluntario['id'], telefone: voluntario['telefone'], nome: voluntario['nome'], cpf: voluntario['cpf'])).toList();
    });

    database.close();
  }

  _buscarCpf(String cpf) async{
    final database = await DB.instance.database;

    List<Map<String, dynamic>> voluntarios = await database.query('voluntarios',where: '"cpf" = ?', whereArgs: ['$cpf']);

    setState(() {
      listaVoluntarios = voluntarios.map((voluntario) => Voluntario(id: voluntario['id'], telefone: voluntario['telefone'], nome: voluntario['nome'], cpf: voluntario['cpf'])).toList();
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
                              child: Center(child: Text("Não possui dados de voluntários!", style: TextStyle(
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
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: listaVoluntarios.length,
                              itemBuilder: (BuildContext context, int index){
                                return VoluntariosList(nome: listaVoluntarios[index].nome, cpf: listaVoluntarios[index].cpf, telefone: listaVoluntarios[index].telefone, function: () => _modal(typeModal.modal, listaVoluntarios[index].id.toString()));
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



  Widget ContainerModalInitOne(BuildContext context, String titleInit) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            bottomLeft: const Radius.circular(0.0),
            bottomRight: const Radius.circular(0.0),
            topLeft: const Radius.circular(8.0),
            topRight: const Radius.circular(8.0),
          )
      ),
      height: 50,
      child: Stack(
        children: [
          Positioned(
              right: 20,
              top: 12,
              child: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                    child: Icon(
                      Icons.close,
                      color: Color(0xFFf0821e),
                      size: 30,
                    )),
              )
          ),
          Padding(
            padding: EdgeInsets.only(top: 17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(titleInit, style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFFf0821e), fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _modal(typeModal type, String id) {
    String titleInitModal = "Opções";
    double heightModal = 344;
    double wightModal = 358;
    showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () {
            Navigator.pop(context);
          },
          child: StatefulBuilder(
            builder: (context, setStateDeletModal) {
              return Dialog(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  backgroundColor: Colors.grey,
                  insetPadding: EdgeInsets.all(8),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                          height: heightModal,
                          width: wightModal,
                          child: Column(
                            children: [
                              ContainerModalInitOne(context, titleInitModal),
                              SizedBox(height: 30),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ButtonOptions("Excluir voluntário", () => _excluirVoluntario(id)),
                                  SizedBox(height: 64),
                                  ButtonOptions("Editar voluntário", () => Navigator.popAndPushNamed(context, editVolunteersRoute, arguments: id)),
                                ],
                              ),
                            ],
                          )),
                    ],
                  ));
            },
          ),
        );
      },
    );
  }

  _excluirVoluntario(String id) async{
    final database = await openDatabase('cnMaraponga.db');

    await database.delete('voluntarios', where: '"id" = ?', whereArgs: ['$id']);

    initState();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        dismissDirection: DismissDirection.down,
        elevation: 5,
        behavior: SnackBarBehavior.floating,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                child: Text("Voluntário excluido com sucesso!"))
          ],
        ),
        backgroundColor: Color(0xFF4FBD2D),
      ),
    );
    database.close();
  }

  Widget ButtonOptions(String texto, Function funcao){
    return Container(
        width: 300,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Color(0xFFf0821e),
        ),
        child: InkWell(
          onTap: (){
            Navigator.pop(context);
            funcao();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                texto,
                style: TextStyle(
                    fontFamily: "OpensSans",
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
        )
    );
  }

}
