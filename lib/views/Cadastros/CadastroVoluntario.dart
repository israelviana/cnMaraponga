import 'dart:convert';

import 'package:app_transito/core/AppImages.dart';
import 'package:app_transito/models/voluntario.dart';
import 'package:app_transito/services/ScalffoldMensage.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../../database/db.dart';

class CadastroVoluntario extends StatefulWidget{
  const CadastroVoluntario({Key key}) : super(key: key);

  State<CadastroVoluntario> createState() => _CadastroVoluntario();
}

class _CadastroVoluntario extends State<CadastroVoluntario> {
  final _formkey = GlobalKey<FormState>();
  final nomeController = TextEditingController(text: '');
  final cpfController = TextEditingController(text: '');
  final telefoneController = TextEditingController(text: '');

  List<Voluntario> listaVoluntario = [];

  var _scaffoldKeyLogIn;


  @override
  Widget build(BuildContext context) {
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
                        Text("Cadastro de Voluntário",
                          style: TextStyle(
                              fontFamily: "OpensSans",
                              fontSize: 28,
                              color: Color(0xFFf0821e)
                          ),
                        ),
                      ],
                    ),
                    ButtonVoluntario()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ButtonVoluntario(){
    return Form(
      key: _formkey,
      child: Padding(
        padding: const EdgeInsets.only(top: 35),
        child: Column(
          children: [
            Text(
              "Nome:",
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 24,
                color: Color(0xFFf0821e),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: _InputForm(nomeController, 'NOME', 'Nome'),
            ),
            SizedBox(height: 20),
            Text(
              "CPF: ",
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 24,
                  color: Color(0xFFf0821e)
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 10),
              child: _InputForm(cpfController, 'CPF', 'CPF'),
            ),
            SizedBox(height: 20),
            Text(
              "Telefone: ",
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 24,
                  color: Color(0xFFf0821e)
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 10),
              child: _InputForm(telefoneController, 'TELEFONE', 'Telefone'),
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
          case "NOME":
            if (value.isEmpty) {
              return "Favor preencher o campo nome.";
            }
            return null;
          case "CPF":
            if (value.isEmpty) {
              return "Favor preencher o campo CPF.";
            }
            return null;
          case "TELEFONE":
            if (value.isEmpty){
              return "Favor preencher o campo telefone.";
            }

        }
      },
      inputFormatters: [_MaskTextInputFormatter(title: title, controller: controller)]
    );
  }

  dynamic _MaskTextInputFormatter({title = "", controller}) {
    switch (title) {
      case "CPF":
        return MaskTextInputFormatter(
            initialText: cpfController.text,
            mask: '###.###.###-##',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy);
      case "TELEFONE":
        return MaskTextInputFormatter(
            initialText: telefoneController.text,
            mask: '(##) #####-####',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy);
      default:
        return MaskTextInputFormatter(
          initialText: controller.text.toUpperCase(),
        );
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
          if (_formkey.currentState.validate()) {
            _adicionarVoluntario();
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Cadastrar",
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

  _adicionarVoluntario() async{
    final database = await DB.instance.database;

    await database.insert('voluntarios', {
      'nome': nomeController.text,
      'cpf': cpfController.text,
      'telefone': telefoneController.text
    });

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
                child: Text("Voluntario cadastrado com sucesso!!"))
          ],
        ),
        backgroundColor:  Color(0xFF4FBD2D),
      ),
    );

    Future.delayed(Duration(milliseconds: 800)).then((_) async {
      Navigator.pop(context);
    });


  }

}