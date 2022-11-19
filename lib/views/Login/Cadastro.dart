import 'package:app_transito/core/AppImages.dart';
import 'package:flutter/material.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key key}) : super(key: key);


  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final congregacaoController = TextEditingController(text: '');
  final emailController = TextEditingController(text: '');
  final senhaControler = TextEditingController(text: '');
  final nomeController = TextEditingController(text: '');
  final telefoneController = TextEditingController(text: '');
  final cargoController = TextEditingController(text: '');
  final cpfController = TextEditingController(text: '');
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF28282b),
      body:
      SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        AppImages.logoMini,
                      ),
                      SizedBox(width: 30),
                      Text("Cadastro",
                        style: TextStyle(
                            fontFamily: "OpensSans",
                            fontSize: 40,
                            color: Color(0xFFf0821e)
                        ),
                      ),
                    ],
                  ),
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
              "Congregação",
              style: TextStyle(
                fontFamily: 'OpensSans',
                fontSize: 20,
                color: Color(0xFFf0821e),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 13, bottom: 13),
              child: _InputForm(
                  congregacaoController, 'Congregação', "CONGREGAÇÃO"),
            ),
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
              child: _InputForm(emailController, "E-mail", "E-mail"),
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
              child: _InputForm(senhaControler, "SENHA", "Senha"),
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
              child: _InputForm(telefoneController, "Telefone", "Telefone"),
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
