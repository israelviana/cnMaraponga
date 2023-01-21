
import 'dart:convert';

import 'package:app_transito/models/escala.dart';
import 'package:app_transito/services/ScalffoldMensage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CadastroEscalas extends StatefulWidget {
  const CadastroEscalas({Key key}) : super(key: key);

  @override
  State<CadastroEscalas> createState() => _CadastroEscalastate();

}
class _CadastroEscalastate extends State<CadastroEscalas>{
  final _formkey = GlobalKey<FormState>();
  final escalaControler = TextEditingController(text: '');
  final dataController = TextEditingController(text: '');
  final horaController = TextEditingController(text: '');

  List<Escala> listEscala = <Escala>[];
  var _scaffoldKeyLogIn;

  @override
  void initState(){
    _getEscalaList();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      key: _scaffoldKeyLogIn,
      backgroundColor: Color(0xFF28282b),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 40),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /*Image.asset(
                          AppImages.logoMini),*/
                      Text("Cadastro de Escalas",
                        style: TextStyle(
                            fontFamily: "OpensSans",
                            fontSize: 28,
                            color: Color(0xFFf0821e)
                        ),
                      ),
                    ],
                  ),
                ButtonEscalas()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

Widget ButtonEscalas(){
    return Form(
      key: _formkey,
      child: Padding(
        padding: const EdgeInsets.only(top: 58),
        child: Column(
          children: [
            Text(
              "Voluntário:",
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 24,
                color: Color(0xFFf0821e),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 13),
              child: _InputForm(escalaControler, 'VOLUNTARIO', 'Volutário'),
            ),
            Text(
              "Data: ",
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 24,
                color: Color(0xFFf0821e)
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 20,bottom: 13),
            child: _InputForm(dataController, 'DATA', 'Data'),
            ),
            Text(
              "Hora: ",
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 24,
                color: Color(0xFFf0821e)
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 15),
            child: _InputForm(horaController, 'HORA', 'hora'),
            ),
            SizedBox(height: 20),
            ButtonConfirmar(),
          ],
        ),
      ),
    );
}

  Widget _InputForm(TextEditingController controller, String title,
      String hintText) {
    return TextFormField(
      cursorColor: Color(0xFFf0821e),
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 5),
        border: OutlineInputBorder(
            borderSide: BorderSide(
                width: 4, color: Color(0xFFf0821e)
            )
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 2, color: Color(0xFFf0821e)
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 2, color: Color(0xFFf0821e)
            )
        ),
        hintText: hintText,
        hintStyle: TextStyle(
            color: Colors.white70
        ),
      ),
      style: TextStyle(
          color: Colors.white70
      ),
      validator: (value) {
        switch (title) {
          case "VOLUNTARIO":
            if (value.isEmpty) {
              return "Favor preencher o campo voluntário";
            }
            return null;
          case "DATA":
            if (value.isEmpty) {
              return "Favor preencher o campo data";
            }
            return null;
          case "HORA":
            if (value.isEmpty){
              return "Favor preencher o campo hora";
            }
        }
      },
    );
  }

  Widget ButtonConfirmar(){
    return Container(
      width: 200,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xFFf0821e),
      ),
      child: InkWell(
        onTap: (){
          if(_formkey.currentState.validate()){
            _adicionarList();
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Confirmar",
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      ),
    );
  }

  void _adicionarList(){
    Escala escala = new Escala(
        voluntario: escalaControler.text,
        hora: horaController.text,
        data: dataController.text
    );

    listEscala.add(escala);
    _saveEscalaList(listEscala);

  }

  Future<void> _saveEscalaList(List<Escala> escalaList) async{
    String jsonEscala = json.encode(escalaList);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("listEscala", jsonEscala);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        dismissDirection: DismissDirection.down,
        elevation: 5,
        behavior: SnackBarBehavior.floating,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                child: Text("Escala cadastrada com sucesso!!"))
          ],
        ),
        backgroundColor:  Color(0xFF4FBD2D),
      ),
    );
    Future.delayed(Duration(milliseconds: 800)).then((_) async {
      Navigator.pop(context);
    });
  }

  _getEscalaList() async {
   listEscala = await loadEscalaList();
  }

  Future<List<Escala>> loadEscalaList() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonEscala = prefs.getString("listEscala");
    listEscala = json.decode(jsonEscala).map((i) => Escala.fromJson(i)).toList();
    return listEscala;
  }
}




