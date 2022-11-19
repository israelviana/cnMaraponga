import 'package:flutter/material.dart';

import '../../core/AppImages.dart';

class EsqueceuSenha extends StatefulWidget {
  const EsqueceuSenha({Key key}) : super(key: key);


  @override
  State<EsqueceuSenha> createState() => _EsqueceuSenhaState();

}

class _EsqueceuSenhaState extends State<EsqueceuSenha> {
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF28282b),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      AppImages.logoMini),
                    SizedBox(width: 25),
                    Text("Lembrar Senha",
                      style: TextStyle(
                          fontFamily: "OpensSans",
                          fontSize: 25,
                          color: Color(0xFFf0821e)
                      ),
                    ),
                  ],
                ),
                FormLembrarSenha(),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget FormLembrarSenha(){
    return Form(
      key: _formkey,
      child: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: Column(
          children: [
            Text(
              "E-mail",
              style: TextStyle(
                fontFamily: "OpenSans",
                fontSize: 20,
                color: Color(0xFFf0821e)
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 20),
              child: _InputForm(emailController, "E-mail", "email@gmail.com"),
            ),
            SizedBox(height: 20),
            ButtonConfirmar(),
          ],
        ),
      ),
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

  }
