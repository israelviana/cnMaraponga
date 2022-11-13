import 'package:app_transito/core/AppImages.dart';
import 'package:flutter/material.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key key}) : super(key: key);

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
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
                        AppImages.logoMini,
                    ),
                    SizedBox(width: 20),
                    Text("Cadastro",
                      style: TextStyle(
                          fontFamily: "OpensSans",
                          fontSize: 40,
                          color: Color(0xFFf0821e)
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
