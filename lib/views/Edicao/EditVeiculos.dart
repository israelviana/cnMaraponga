
import 'dart:convert';

import 'package:app_transito/models/veiculos.dart';
import 'package:app_transito/router.dart';
import 'package:app_transito/services/ScalffoldMensage.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/AppImages.dart';
import '../../database/db.dart';

class EditVeiculos extends StatefulWidget{
  const EditVeiculos({Key key, this.id}) : super(key: key);
  final id;

  State<EditVeiculos> createState() => _EditVeiculos();
}

class _EditVeiculos extends State<EditVeiculos>{
  final _formkey = GlobalKey<FormState>();
  final modeloController = TextEditingController(text: '');
  final corController = TextEditingController(text: '');
  final placaController = TextEditingController(text: '');
  final condutorController = TextEditingController(text: '');
  final telefoneController = TextEditingController(text: '');

  List<Veiculo> listVeiculo = [];

  var _scaffoldKeyLogIn;

  @override
  void initState(){
    _findByIdVeiculo();
  }

  _findByIdVeiculo() async{
    final database = await openDatabase('cnMaraponga.db');

    List<Map<String, dynamic>> veiculos = await database.query('veiculos', where: '"id" = ?', whereArgs: ['${widget.id}'], limit: 1);

    setState(() {
      listVeiculo = veiculos.map((veiculo) => Veiculo(id: veiculo['id'], telefone: veiculo['telefone'], placa: veiculo['placa'], modelo: veiculo['modelo'], cor: veiculo['cor'], condutor: veiculo['condutor'])).toList();
      modeloController.text = listVeiculo[0].modelo;
      corController.text = listVeiculo[0].cor;
      placaController.text = listVeiculo[0].placa;
      condutorController.text = listVeiculo[0].condutor;
      telefoneController.text = listVeiculo[0].telefone;
    });

    database.close();

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
                        Text("Edição de Veículo",
                          style: TextStyle(
                              fontFamily: "OpensSans",
                              fontSize: 28,
                              color: Color(0xFFf0821e)
                          ),
                        ),
                      ],
                    ),
                    ButtonVeiculos()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ButtonVeiculos(){
    return Form(
      key: _formkey,
      child: Padding(
        padding: const EdgeInsets.only(top: 35),
        child: Column(
          children: [
            Text(
              "Modelo:",
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 24,
                color: Color(0xFFf0821e),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: _InputForm(modeloController, 'MODELO', 'Modelo'),
            ),
            Text(
              "Cor: ",
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 24,
                  color: Color(0xFFf0821e)
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 10),
              child: _InputForm(corController, 'COR', 'Cor'),
            ),
            Text(
              "Placa: ",
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 24,
                  color: Color(0xFFf0821e)
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 10),
              child: _InputForm(placaController, 'PLACA', 'Placa'),
            ),
            SizedBox(height: 20),
            Text(
              "Condutor: ",
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 24,
                  color: Color(0xFFf0821e)
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 10),
              child: _InputForm(condutorController, 'CONDUTOR', 'Condutor'),
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
            case "MODELO":
              if (value.isEmpty) {
                return "Favor preencher o campo modelo.";
              }
              return null;
            case "COR":
              if (value.isEmpty) {
                return "Favor preencher o campo cor.";
              }
              return null;
            case "PLACA":
              if (value.isEmpty){
                return "Favor preencher o campo placa.";
              }
              return null;
            case "CONDUTOR":
              if (value.isEmpty){
                return "Favor preencher o campo condutor.";
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
      case "PLACA":
        return MaskTextInputFormatter(
            initialText: placaController.text,
            mask: '###-####',
            filter: {"#": RegExp(r'[A-Za-z0-9]')},
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
            _editVeiculo();
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

  _editVeiculo() async{
    final database = await DB.instance.database;

    await database.update('veiculos', {
      'cor': corController.text,
      'placa': placaController.text,
      'condutor': condutorController.text,
      'modelo': modeloController.text,
      'telefone': telefoneController.text
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
                child: Text("Veículo editado com sucesso!"))
          ],
        ),
        backgroundColor:  Color(0xFF4FBD2D),
      ),
    );

    Future.delayed(Duration(milliseconds: 800)).then((_) async {
      Navigator.popAndPushNamed(context, veiculosRoute);
    });
  }

}