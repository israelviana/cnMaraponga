import 'dart:convert';

import 'package:app_transito/core/AppImages.dart';
import 'package:app_transito/router.dart';
import 'package:app_transito/services/ScalffoldMensage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

import '../../models/user.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}



class _LoginState extends State<Login> {
  final emailController = TextEditingController(text: '');
  final senhaController = TextEditingController(text: '');
  final _formkey = GlobalKey<FormState>();

  bool _showPassword = false;
  var _scaffoldKeyLogIn;

  @override
  void initState() {
    _scaffoldKeyLogIn = GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFF28282b),
        key: _scaffoldKeyLogIn,
        body: SingleChildScrollView(
          child: Padding(

            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
            child: Column(
              children: [
                Image.asset(AppImages.logoAplicativo),
                FormLogin(),
                SizedBox(height: 40),
               /*Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(AppImages.logoMini)
                  ],
                )*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget FormLogin(){
    return Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.only(top: 70),
          child: Column(
            children: [
              Text(
                "E-mail",
                style: TextStyle(
                    fontFamily: "OpensSans",
                    fontSize: 20,
                    color: Color(0xFFf0821e)
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: _InputForm(emailController, "EMAIL", "Digite seu email."),
              ),
              Text(
                "Senha",
                style: TextStyle(
                    fontFamily: "OpensSans",
                    fontSize: 20,
                    color: Color(0xFFf0821e)
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: _InputSenha(senhaController, "SENHA", "Digite sua senha."),
              ),
              SizedBox(height: 20),
              ButtonConfirmar(),
              SizedBox(height: 30),
              naoPossuiConta(),
              SizedBox(height: 15),
              /*esqueceuSenha(),*/
            ],
          ),
        )
    );
  }

  Widget _InputForm(TextEditingController controller, String title, String hintText){
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
      validator: (value){
        switch (title){
          case "EMAIL":
            if(value.isEmpty){
              return "Favor preencher o campo e-mail";
            }
            return null;
          case "SENHA":
            if(value.isEmpty){
              return "Favor preencher o campo senha";
            }
            return null;
        }
      },
    );
  }

  Widget _InputSenha(TextEditingController controller, String title, String hintText){
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

          suffixIcon: GestureDetector(
            child: Icon( _showPassword == false ? Icons.visibility_off : Icons.visibility, color: Color(0xFFf0821e),
            ),
            onTap: (){
              setState(() {
                _showPassword = !_showPassword;
              });
            },
          )
      ),
      obscureText: _showPassword == false ? true : false,
      style: TextStyle(
          color: Colors.white70
      ),
      validator: (value){
        switch (title){
          case "SENHA":
            if(value.isEmpty){
              return "Favor preencher o campo e-mail";
            }
            return null;
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
            if (_formkey.currentState.validate()){
              _doLogin();
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Entrar",
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

  Widget naoPossuiConta(){
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, cadastroRoute);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Cadastre-se ",
            style: TextStyle(
                fontSize: 15,
                color: Color(0xFFf0821e),
                fontWeight: FontWeight.w400,

            ),
          ),

        ],
      ),
    );
  }
  Widget esqueceuSenha(){
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, esqueceuSenhaRoute);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Esqueceu a senha?",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Color(0xFFf0821e)
            ),
          )
        ],
      ),
    );
  }

  _doLogin() async{
    String mail = this.emailController.text;
    String password = this.senhaController.text;

    User savedUser = await _getSavedUser();

    if(mail == savedUser.mail && password == savedUser.password){
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          dismissDirection: DismissDirection.down,
          elevation: 5,
          behavior: SnackBarBehavior.floating,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                  child: Text("Seja bem-vindo!"))
            ],
          ),
          backgroundColor:  Color(0xFF4FBD2D),
        ),
      );
      Future.delayed(Duration(milliseconds: 800)).then((_) async {
        Navigator.pushNamed(context, inicialRoute);
      });
    }else{
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          dismissDirection: DismissDirection.down,
          elevation: 5,
          behavior: SnackBarBehavior.floating,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                  child: Text("Email ou Senha incorretos!"))
            ],
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<User> _getSavedUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonUser = prefs.getString("LoginUserInfos");
    Map<String, dynamic> mapUser = json.decode(jsonUser);
    User user = User.fromJson(mapUser);

    return user;
  }

}
