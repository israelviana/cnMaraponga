import 'dart:convert';

import 'package:app_transito/views/Veiculos/Widgets/VeiculosList.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    requisitionVeiculo = _loadVeiculoList();
  }

  Future<List<Veiculo>> _loadVeiculoList() async{
    final prefs = await SharedPreferences.getInstance();
    final listVeiculos = prefs.getString('veiculosKey');

    if (listVeiculos != null){
      List<dynamic> objectVeiculos = jsonDecode(listVeiculos);
      return objectVeiculos.map((e) => Veiculo.fromJson(e)).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF28282b),
        body: FutureBuilder(
            future: requisitionVeiculo,
            builder: (context, snapshot){
              if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
                listVeiculo = snapshot.data;
                return Column(
                  children: [
                    SizedBox(height: 20),
                    Text("VEÍCULOS", style: TextStyle(
                        fontFamily: "OpensSans",
                        fontSize: 40,
                        color: Color(0xFFf0821e)
                    )),
                    SizedBox(height: 20),
                    Column(
                      children: List.generate(listVeiculo.length, (index) {
                        return VeiculosList(modelo: listVeiculo[index].modelo, cor: listVeiculo[index].cor, placa: listVeiculo[index].placa, condutor: listVeiculo[index].condutor, telefone: listVeiculo[index].telefone);
                      }).toList(),
                    )
                  ],
                );
              }else if(!snapshot.hasData && snapshot.connectionState == ConnectionState.done){
                return Center(child: Text("Não possui dados de veiculos!!!", style: TextStyle(
                    fontFamily: "OpensSans",
                    fontSize: 20,
                    color: Color(0xFFf0821e)
                ),));
              }else{
                return CircularProgressIndicator();
              }
            }
        ),
      ),
    );
  }
}
