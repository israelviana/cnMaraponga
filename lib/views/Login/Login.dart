import 'package:app_transito/core/AppImages.dart';
import 'package:app_transito/router.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController(text: '');
  final senhaController = TextEditingController(text: '');
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF28282b),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
        child: Column(
          children: [
            Image.asset(AppImages.logoAplicativo),
            FormLogin(),
            SizedBox(height: 40),
           /* Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(AppImages.logoMini)
              ],
            )*/
          ],
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
                child: _InputForm(senhaController, "SENHA", "Digite sua senha."),
              ),
              SizedBox(height: 20),
              ButtonConfirmar(),
              SizedBox(height: 30),
              naoPossuiConta(),
              SizedBox(height: 15),
              esqueceuSenha(),
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
            _formkey.currentState.validate();
            Navigator.pushNamed(context, inicialRoute);
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


  void getRequisicao() async {
    var url = Uri.parse('http://192.168.1.6:3000/sign');
    String body = convert.jsonEncode({
      "email": emailController,
      "senha": senhaController
    });
    try{
      var response = await http.post(url, body: body);
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
    }catch(err){
      print(err);
    }
  }

}
