import 'package:app_transito/views/Voluntarios/Widgets/VoluntariosList.dart';
import 'package:flutter/material.dart';

class Voluntarios extends StatefulWidget {
  const Voluntarios({Key key}) : super(key: key);

  @override
  State<Voluntarios> createState() => _VoluntariosState();
}

class _VoluntariosState extends State<Voluntarios> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF28282b),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Column(
            children: [
              Text("VOLUNTÁRIOS", style: TextStyle(
                  fontFamily: "OpensSans",
                  fontSize: 40,
                  color: Color(0xFFf0821e)
              )),
              SizedBox(height: 20),
              VoluntariosList(nome: "EU", cpf: "eu", telefone: "eu"),
            ],
          ),
        ),
      ),
    );
  }
}
