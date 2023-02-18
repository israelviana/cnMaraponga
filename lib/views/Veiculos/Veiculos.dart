import 'package:app_transito/views/Veiculos/Widgets/VeiculosList.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/veiculos.dart';

class Veiculos extends StatefulWidget {
  const Veiculos({Key key}) : super(key: key);

  @override
  State<Veiculos> createState() => _VeiculosState();
}

class _VeiculosState extends State<Veiculos> {
  Future requisitionVeiculo;

  List<Veiculo> listVeiculo = [];


  @override
  void initState(){
    _carregarVeiculos();
  }


  _carregarVeiculos() async{
    final database = await openDatabase('cnMaraponga.db');

    List<Map<String, dynamic>> veiculos = await database.query('veiculos');

    setState(() {
      listVeiculo = veiculos.map((veiculo) => Veiculo(telefone: veiculo['telefone'], placa: veiculo['placa'], modelo: veiculo['modelo'], cor: veiculo['cor'], condutor: veiculo['condutor'])).toList();
    });

    database.close();

  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF28282b),
        body: CustomScrollView(
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
                      listVeiculo.length == 0 ?
                          Center(child: Text("Não possui dados de veiculos!!!", style: TextStyle(
                              fontFamily: "OpensSans",
                              fontSize: 20,
                              color: Color(0xFFf0821e)
                          ))) :
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: listVeiculo.length,
                          itemBuilder: (BuildContext context, int index){
                            return VeiculosList(modelo: listVeiculo[index].modelo, cor: listVeiculo[index].cor, placa: listVeiculo[index].placa, condutor: listVeiculo[index].condutor, telefone: listVeiculo[index].telefone);
                          }
                      )
                    ],
                  )
                  ])
            )
          ],
        )
      ),
    );
  }
}
