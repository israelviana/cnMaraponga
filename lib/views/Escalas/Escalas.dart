import 'package:app_transito/views/Escalas/Widgets/EscalasList.dart';
import 'package:flutter/material.dart';

class Escalas extends StatefulWidget {
  const Escalas({Key key}) : super(key: key);

  @override
  State<Escalas> createState() => _EscalasState();
}


class _EscalasState extends State<Escalas> {


  @override
  void initState(){
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF28282b),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Column(
           children: [
             Text("ESCALAS", style: TextStyle(
                 fontFamily: "OpensSans",
                 fontSize: 40,
                 color: Color(0xFFf0821e)
             )),
             SizedBox(height: 20),
             EscalasList(voluntario: "EU", data: "eu", descricao: "eu", hora: "eu"),
           ],
          ),
        ),
      ),
    );
  }
}


