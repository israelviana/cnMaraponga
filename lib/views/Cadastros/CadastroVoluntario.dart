import 'package:app_transito/core/AppImages.dart';
import 'package:flutter/material.dart';

class CadastroVoluntario extends StatefulWidget{
  const CadastroVoluntario({Key key}) : super(key: key);

  State<CadastroVoluntario> createState() => _CadastroVoluntario();
}

class _CadastroVoluntario extends State<CadastroVoluntario> {
  final _formkey = GlobalKey<FormState>();
  final nomeController = TextEditingController(text: '');
  final cpfController = TextEditingController(text: '');
  final telefoneController = TextEditingController(text: '');

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF28282b),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 71),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                          AppImages.logoMini),
                      SizedBox(width: 40),
                      Text("Voluntario",
                        style: TextStyle(
                            fontFamily: "OpensSans",
                            fontSize: 25,
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
                fontSize: 25,
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
                  fontSize: 25,
                  color: Color(0xFFf0821e)
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 10),
              child: _InputForm(cpfController, 'CPF', 'Cpf'),
            ),
            SizedBox(height: 20),
            Text(
              "Telefone: ",
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 25,
                  color: Color(0xFFf0821e)
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 10),
              child: _InputForm(telefoneController, 'TELEFONE', 'Telefone'),
            ),
            SizedBox(height: 20),
            ButtonConfirmar()

            ,
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

      ),
      validator: (value) {
        switch (title) {
          case "NOME":
            if (value.isEmpty) {
              return "Favor preencher o campo nome";
            }
            return null;
          case "CPF":
            if (value.isEmpty) {
              return "Favor preencher o campo cpf";
            }
            return null;
          case "TELEFONE":
            if (value.isEmpty){
              return "Favor preencher o campo telefone";
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
          _formkey.currentState.validate();
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


}