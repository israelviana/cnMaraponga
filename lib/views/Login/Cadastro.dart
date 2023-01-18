import 'dart:convert';

import 'package:app_transito/core/AppImages.dart';
import 'package:app_transito/models/user.dart';
import 'package:app_transito/services/ScalffoldMensage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key key}) : super(key: key);


  @override
  State<Cadastro> createState() => _CadastroState();
}


class _CadastroState extends State<Cadastro> {

  final emailController = TextEditingController(text: '');
  final senhaController = TextEditingController(text: '');
  final nomeController = TextEditingController(text: '');
  final telefoneController = TextEditingController(text: '');
  final cargoController = TextEditingController(text: '');
  final cpfController = TextEditingController(text: '');
  final _formkey = GlobalKey<FormState>();


  var _scaffoldKeyLogIn;

  @override
  void initState() {
    _scaffoldKeyLogIn = GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF28282b),
      key: _scaffoldKeyLogIn,
      body:
      SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /*Image.asset(
                        AppImages.logoMini,
                      ),*/
                      Text("Cadastro",
                        style: TextStyle(
                            fontFamily: "OpensSans",
                            fontSize: 40,
                            color: Color(0xFFf0821e)
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  formCadastro()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget formCadastro() {
    return Form(
      key: _formkey,
      child: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Column(
          children: [
            Text(
              "Nome: ",
              style: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 18,
                  color: Color(0xFFf0821e)
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 13, bottom: 13),
              child: _InputForm(nomeController, "NOME", "Nome Completo"),
            ),
            Text(
              "E-mail ",
              style: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 20,
                  color: Color(0xFFf0821e)
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 13, bottom: 15),
              child: _InputForm(emailController, "EMAIL", "E-mail"),
            ),
            Text(
              "Senha",
              style: TextStyle(
                fontFamily: "OpenSans",
                fontSize: 20,
                color: Color(0xFFf0821e),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 13, bottom: 15),
              child: _InputForm(senhaController, "SENHA", "Senha"),
            ),
            Text(
              "Telefone",
              style: TextStyle(
                fontFamily: "OpenSans",
                fontSize: 20,
                color: Color(0xFFf0821e),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 13, bottom: 15),
              child: _InputForm(telefoneController, "TELEFONE", "Telefone"),
            ),
            Text(
              "Cargo",
              style: TextStyle(
                fontFamily: "OpenSans",
                fontSize: 20,
                color: Color(0xFFf0821e),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 13, bottom: 15),
              child: _InputForm(cargoController, "CARGO", "Cargo"),
            ),
            Text(
              "CPF",
              style: TextStyle(
                fontFamily: "OpenSans",
                fontSize: 20,
                color: Color(0xFFf0821e),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 13, bottom: 15),
              child: _InputForm(cpfController, "CPF", "CPF"),
            ),
            SizedBox(height: 20),
            ButtonConfirmar(),
            SizedBox(height: 20)
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
          case "EMAIL":
            if (value.isEmpty) {
              return "Favor preencher o campo e-mail";
            }
            return null;
          case "SENHA":
            if (value.isEmpty) {
              return "Favor preencher o campo senha";
            }
            return null;
          case "TELEFONE":
            if (value.isEmpty){
              return "Favor preencher o campo telefone";
            }
            return null;
          case "NOME":
            if (value.isEmpty){
              return "Favor preencher o campo Nome";
            }
            return null;
          case "CARGO":
            if (value.isEmpty){
              return "Favor preecher o cargo nome";
            }
            return null;
          case "CPF":
            if (value.isEmpty){
              return "Favor preencher o campo CPF";
            }
            return null;
        }
      },
    );
  }

  Widget ButtonConfirmar() {
    return Container(
        width: 200,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFFf0821e),
        ),
        child: InkWell(
          onTap: () {
            if(_formkey.currentState.validate()){
              _doSign();
              ScalffoldMensage.messageSucessLogin(
                  "Cadastro realizado com sucesso!", _scaffoldKeyLogIn);
              Navigator.pop(context);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Confirmar",
                style: TextStyle(
                    fontFamily: "OpensSans",
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
        )
    );
  }

  void _doSign(){
    User newUser = User(
      name: nomeController.text,
      mail: emailController.text,
      password: senhaController.text,
      keepOn: true
    );
    _saveUser(newUser);

  }

  void _saveUser(User user) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("LoginUserInfos", json.encode(user.toJson()));
    
  }

}

