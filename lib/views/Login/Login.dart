import 'package:app_transito/core/AppImages.dart';
import 'package:app_transito/router.dart';
import 'package:flutter/material.dart';

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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(AppImages.logoMini)
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget FormLogin(){
    return Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.only(top: 80),
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
                child: _InputForm(emailController, "EMAIL", "email@email.com"),
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
                child: _InputForm(senhaController, "SENHA", "12345678"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  esqueceuSenha(),
                ],
              ),
              SizedBox(height: 20),
              ButtonConfirmar(),
              SizedBox(height: 30),
              naoPossuiConta(),
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
      onTap: (){},
      child: Row(
        children: [
          Text("Ainda não possui uma conta? ",
            style: TextStyle(
                fontFamily: "OpensSans",
                fontSize: 15,
                color: Color(0xFFf0821e)
            ),
          ),
          SizedBox(width: 20),
          Text("Clique aqui", style: TextStyle(
              fontFamily: "OpensSans",
              fontSize: 15,
              color: Color(0xFFf0821e)
          )
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
        children: [
          SizedBox(width: 20),
          Text(
            "Esqueceu a senha?",
            style: TextStyle(
                fontFamily: "OpensSans",
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFFf0821e)
            ),
          )
        ],
      ),
    );
  }
}
