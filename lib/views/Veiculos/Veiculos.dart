import 'dart:ffi';

import 'package:app_transito/router.dart';
import 'package:app_transito/views/Veiculos/Widgets/VeiculosList.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../components/inputForm.dart';
import '../../database/db.dart';
import '../../models/veiculos.dart';

enum typeModal{
  modal
}

class Veiculos extends StatefulWidget {
  const Veiculos({Key key}) : super(key: key);

  @override
  State<Veiculos> createState() => _VeiculosState();
}

class _VeiculosState extends State<Veiculos> {
  Future requisitionVeiculo;

  List<Veiculo> listVeiculo = [];

  final placaController = TextEditingController(text: '');

  String placa;


  @override
  void initState(){
    _carregarVeiculos();
    placaController.text = "";
  }


  _carregarVeiculos() async{
    final database = await DB.instance.database;

    List<Map<String, dynamic>> veiculos = await database.query('veiculos');

    setState(() {
      listVeiculo = veiculos.map((veiculo) => Veiculo(id: veiculo['id'], telefone: veiculo['telefone'], placa: veiculo['placa'], modelo: veiculo['modelo'], cor: veiculo['cor'], condutor: veiculo['condutor'])).toList();
    });

    database.close();

  }

  _buscarPlaca(String placa) async{
    final database = await DB.instance.database;

    List<Map<String, dynamic>> veiculos = await database.query('veiculos', where: '"placa" = ?', whereArgs: ['$placa']);

    setState(() {
      listVeiculo = veiculos.map((veiculo) => Veiculo(id: veiculo['id'] ,telefone: veiculo['telefone'], placa: veiculo['placa'], modelo: veiculo['modelo'], cor: veiculo['cor'], condutor: veiculo['condutor'])).toList();
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
                        Text("VEÍCULOS", style: TextStyle(
                            fontFamily: "OpensSans",
                            fontSize: 40,
                            color: Color(0xFFf0821e)
                        )),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Flexible(child: InputForm(title: 'Digite a PLACA pelo qual deseja buscar', mask: "PLACA", type: "TEXT", controller: placaController)),
                              InkWell(
                                onTap: (){
                                  placa = placaController.text;
                                  if(placa == ""){
                                    initState();
                                  }else{
                                    _buscarPlaca(placa);
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
                        listVeiculo.length == 0 ?
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Center(child: Text("Não possui dados de veiculos!!!", style: TextStyle(
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
                              itemCount: listVeiculo.length,
                              itemBuilder: (BuildContext context, int index){
                                return VeiculosList(modelo: listVeiculo[index].modelo, cor: listVeiculo[index].cor, placa: listVeiculo[index].placa, condutor: listVeiculo[index].condutor, telefone: listVeiculo[index].telefone, funcao: () => _modal(typeModal.modal, listVeiculo[index].id.toString()));
                              }
                          ),
                        )
                      ],
                    )
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
                                  ButtonOptions("Excluir veiculo", () => _excluirVeiculo(id)),
                                  SizedBox(height: 64),
                                  ButtonOptions("Editar veiculo", () => Navigator.popAndPushNamed(context, edicaoVeiculoRoute, arguments: id)),
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

  _excluirVeiculo(String id) async{
    final database = await openDatabase('cnMaraponga.db');

    await database.delete('veiculos', where: '"id" = ?', whereArgs: ['$id']);

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
                child: Text("Veiculo excluido com sucesso!!"))
          ],
        ),
        backgroundColor:  Color(0xFF4FBD2D),
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

