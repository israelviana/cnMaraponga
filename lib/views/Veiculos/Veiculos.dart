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


  @override
  void initState(){
    requisitionVeiculo = loadVeiculoList();
  }

  Future<List<Veiculo>> loadVeiculoList() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getVeiculoList("listVeiculo");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF28282b),
      body: FutureBuilder(
          future: requisitionVeiculo,
          builder: (context, snapshot){
            if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
              List<Veiculo> veiculo = <Veiculo>[];
              veiculo = snapshot.data;
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
                    children: List.generate(veiculo.length, (index) {
                      return VeiculosList(modelo: veiculo[index].modelo, cor: veiculo[index].cor, placa: veiculo[index].placa, condutor: veiculo[index].condutor, telefone: veiculo[index].telefone);
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
    );
  }
}
