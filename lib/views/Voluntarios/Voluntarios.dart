import 'package:app_transito/models/voluntario.dart';
import 'package:app_transito/views/Voluntarios/Widgets/VoluntariosList.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Voluntarios extends StatefulWidget {
  const Voluntarios({Key key}) : super(key: key);

  @override
  State<Voluntarios> createState() => _VoluntariosState();
}

class _VoluntariosState extends State<Voluntarios> {


  Future requisitionVoluntario;


  @override
  void initState(){
    requisitionVoluntario = loadVoluntarioList();
  }

  Future<List<Voluntario>> loadVoluntarioList() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getVoluntarioList("listVoluntario");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF28282b),
      body: FutureBuilder(
        future: requisitionVoluntario,
        builder: (context, snapshot){
          if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
            List<Voluntario> voluntario = <Voluntario>[];
            voluntario = snapshot.data;
            return Column(
              children: [
                Text("VOLUNTÁRIOS", style: TextStyle(
                    fontFamily: "OpensSans",
                    fontSize: 40,
                    color: Color(0xFFf0821e)
                )),
                SizedBox(height: 20),
                Column(
                  children: List.generate(voluntario.length, (index) {
                    return VoluntariosList(nome: voluntario[index].nome, cpf: voluntario[index].cpf, telefone: voluntario[index].telefone);
                  }),
                )
              ],
            );
          }else if(!snapshot.hasData && snapshot.connectionState == ConnectionState.done){
            return Center(child: Text("Não possui dados de voluntarios!!!", style: TextStyle(
                fontFamily: "OpensSans",
                fontSize: 20,
                color: Color(0xFFf0821e)
            ),));
          }else{
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
