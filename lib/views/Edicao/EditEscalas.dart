
import 'dart:convert';

import 'package:app_transito/core/AppImages.dart';
import 'package:app_transito/models/escala.dart';
import 'package:app_transito/router.dart';
import 'package:app_transito/services/ScalffoldMensage.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../../database/db.dart';

class EditEscalas extends StatefulWidget {
  const EditEscalas({Key key, this.id}) : super(key: key);
  final id;

  @override
  State<EditEscalas> createState() => _EditEscalasState();

}
class _EditEscalasState extends State<EditEscalas>{
  final _formkey = GlobalKey<FormState>();
  final escalaControler = TextEditingController(text: '');
  final dataController = TextEditingController(text: '');
  final horaController = TextEditingController(text: '');

  List<Escala> listaDeEscala = [];

  var _scaffoldKeyLogIn;

  @override
  void initState(){
    _findByIdEscala();

  }

  _findByIdEscala() async{
    final database = await DB.instance.database;

    List<Map<String, dynamic>> escalas = await database.query('escalas', where: '"id" = ?', whereArgs: ['${widget.id}'], limit: 1);

    setState(() {
      listaDeEscala = escalas.map((escala) => Escala(id: escala['id'], voluntario:  escala['nome'], data: escala['data'], hora: escala['hora'])).toList();
      escalaControler.text = listaDeEscala[0].voluntario;
      dataController.text = listaDeEscala[0].data;
      horaController.text = listaDeEscala[0].hora;
    });

    database.close();
  }

  _updateEscala() async {

    final database = await openDatabase('cnMaraponga.db');

    await database.update('escalas', {
      'nome': escalaControler.text,
      'data': dataController.text,
      'hora': horaController.text
    },
      where: '"id" = ?',
      whereArgs: ['${widget.id}']
    );

    database.close();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        dismissDirection: DismissDirection.down,
        elevation: 5,
        behavior: SnackBarBehavior.floating,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                child: Text("Escala editada com sucesso!"))
          ],
        ),
        backgroundColor:  Color(0xFF4FBD2D),
      ),
    );

    Future.delayed(Duration(milliseconds: 800)).then((_) async {
      Navigator.popAndPushNamed(context, escalasRoute);
    });
  }

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKeyLogIn,
        backgroundColor: Color(0xFF28282b),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                child: Column(
                  children: [
                    Image.asset(AppImages.logoAplicativo),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Edição de Escalas",
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
        inputFormatters: [_MaskTextInputFormatter(title: title)]
    );
  }

  dynamic _MaskTextInputFormatter({title = ""}) {
    switch (title) {
      case "DATA":
        return MaskTextInputFormatter(
            initialText: dataController.text,
            mask: '##/##/####',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy);
      case "HORA":
        return MaskTextInputFormatter(
            initialText: horaController.text,
            mask: '##:##',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy);
      default:
        return MaskTextInputFormatter(
            initialText: escalaControler.text.toUpperCase());
    }

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
          if(_formkey.currentState.validate()) {
            _updateEscala();
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Editar",
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

}




