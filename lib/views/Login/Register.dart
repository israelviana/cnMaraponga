import 'dart:convert';

import 'package:app_transito/models/User.dart';
import 'package:app_transito/services/ScalffoldMensage.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailController = TextEditingController(text: '');
  final senhaController = TextEditingController(text: '');
  final confirmeSenhaController = TextEditingController(text: '');
  final nomeController = TextEditingController(text: '');
  final telefoneController = TextEditingController(text: '');
  final cargoController = TextEditingController(text: '');
  final cpfController = TextEditingController(text: '');
  final _formkey = GlobalKey<FormState>();

  var _scaffoldKeyLogIn;

  var contextModal;

  @override
  void initState() {
    _scaffoldKeyLogIn = GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF28282b),
        key: _scaffoldKeyLogIn,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /*Image.asset(
                          AppImages.logoMini,
                        ),*/
                        Text(
                          "Cadastro",
                          style: TextStyle(
                              fontFamily: "OpensSans",
                              fontSize: 40,
                              color: Color(0xFFf0821e)),
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
                  color: Color(0xFFf0821e)),
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
                  color: Color(0xFFf0821e)),
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
              "Confirme Senha",
              style: TextStyle(
                fontFamily: "OpenSans",
                fontSize: 20,
                color: Color(0xFFf0821e),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 13, bottom: 15),
              child: _InputForm(
                  confirmeSenhaController, "confirmeSenha", "Confirme a Senha"),
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
              child: _InputForm(
                cpfController,
                "CPF",
                "CPF",
              ),
            ),
            SizedBox(height: 20),
            ButtonConfirmar("2"),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  Widget _InputForm(
      TextEditingController controller, String title, String hintText) {
    return TextFormField(
      cursorColor: Color(0xFFf0821e),
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 5),
        border: OutlineInputBorder(
            borderSide: BorderSide(width: 4, color: Color(0xFFf0821e))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xFFf0821e))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xFFf0821e))),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white70),
      ),
      style: TextStyle(color: Colors.white70),
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
          case "confirmeSenha":
            if (value.isEmpty) {
              return "Favor preencher o campo senha";
            }
            return null;
          case "TELEFONE":
            if (value.isEmpty) {
              return "Favor preencher o campo telefone";
            }
            return null;
          case "NOME":
            if (value.isEmpty) {
              return "Favor preencher o campo Nome";
            }
            return null;
          case "CARGO":
            if (value.isEmpty) {
              return "Favor preecher o cargo nome";
            }
            return null;
          case "CPF":
            if (value.isEmpty) {
              return "Favor preencher o campo CPF";
            }
            return null;
        }
      },
      inputFormatters: [
        _MaskTextInputFormatter(title: title, controller: controller)
      ],
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

  Widget ButtonConfirmar(String type) {
    return Container(
        width: 200,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFFf0821e),
        ),
        child: InkWell(
          onTap: () {
            if (type == "1") {
              if (_formkey.currentState.validate()) {
                if (senhaController.text != confirmeSenhaController.text) {
                  Navigator.pop(contextModal);
                  ScalffoldMensage.messageErrorLogin(
                      "SENHAS DIFERENTES!", _scaffoldKeyLogIn);
                } else {
                  _doSign();
                  Navigator.pop(contextModal);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      dismissDirection: DismissDirection.down,
                      elevation: 5,
                      behavior: SnackBarBehavior.floating,
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                              child: Text("Cadastro realizado com sucesso!"))
                        ],
                      ),
                      backgroundColor: Color(0xFF4FBD2D),
                    ),
                  );
                  Future.delayed(Duration(seconds: 2)).then((_) async {
                    Navigator.pop(context);
                  });
                }
              }
            } else if (type == "2") {
              if (_formkey.currentState.validate()) {
                _modal();
              }
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
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ));
  }

  void _doSign() {
    User newUser = User(
        name: nomeController.text,
        mail: emailController.text,
        password: senhaController.text,
        keepOn: true);
    _saveUser(newUser);
  }

  void _saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("LoginUserInfos", json.encode(user.toJson()));
  }

  _modal() {
    String titleInitModal = "Opções";
    double heightModal = 250;
    double wightModal = 358;
    showDialog(
      context: context,
      builder: (context) {
        contextModal = context;
        return WillPopScope(
          onWillPop: () {
            Navigator.pop(context);
          },
          child: StatefulBuilder(
            builder: (context, setStateDeletModal) {
              return Dialog(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  backgroundColor: Colors.grey,
                  insetPadding: EdgeInsets.all(8),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                          height: heightModal,
                          width: wightModal,
                          child: Column(
                            children: [
                              ContainerModalInitOne(context, titleInitModal),
                              SizedBox(height: 30),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                      "No atual momento só é possível \n cadastrar um usuário por vez!",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18)),
                                  SizedBox(height: 50),
                                  ButtonConfirmar("1"),
                                ],
                              ),
                            ],
                          )),
                    ],
                  ));
            },
          ),
        );
      },
    );
  }

  Widget ContainerModalInitOne(BuildContext context, String titleInit) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            bottomLeft: const Radius.circular(0.0),
            bottomRight: const Radius.circular(0.0),
            topLeft: const Radius.circular(8.0),
            topRight: const Radius.circular(8.0),
          )),
      height: 50,
      child: Stack(
        children: [
          Positioned(
              right: 20,
              top: 12,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    child: Icon(
                  Icons.close,
                  color: Color(0xFFf0821e),
                  size: 30,
                )),
              )),
          Padding(
            padding: EdgeInsets.only(top: 17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Aviso!",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFf0821e),
                        fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
