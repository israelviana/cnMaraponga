import 'package:app_transito/views/Veiculos/Widgets/VeiculosList.dart';
import 'package:flutter/material.dart';

class Veiculos extends StatefulWidget {
  const Veiculos({Key key}) : super(key: key);

  @override
  State<Veiculos> createState() => _VeiculosState();
}

class _VeiculosState extends State<Veiculos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF28282b),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Column(
            children: [
              Text("VEÍCULOS", style: TextStyle(
                  fontFamily: "OpensSans",
                  fontSize: 40,
                  color: Color(0xFFf0821e)
              )),
              SizedBox(height: 20),
              VeiculosList(modelo: "EU", cor: "EU", placa: "EU", condutor: "EU", telefone: "EU")
            ],
          ),
        ),
      ),
    );
  }
}
