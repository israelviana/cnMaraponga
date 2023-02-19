import 'package:flutter/material.dart';

class VoluntariosList extends StatelessWidget {
  VoluntariosList(
      {Key key,
        @required this.nome,
        @required this.cpf,
        @required this.telefone,
        @required this.function
      })
      : super(key: key);

  final nome, cpf, telefone, function;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Container(
            constraints: BoxConstraints(
              minWidth: 358,
              minHeight: size.height * 0.15,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 16),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Nome: ',
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700
                                )
                            ),
                            TextSpan(
                              text: nome,
                              style: TextStyle(
                                  fontFamily: "OpensSans",
                                  fontSize: 14,
                                  color: Color(0xFFf0821e)
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'CPF: ',
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700)),
                            TextSpan(
                              text: cpf,
                              style: TextStyle(
                                  fontFamily: "OpensSans",
                                  fontSize: 14,
                                  color: Color(0xFFf0821e)),
                            )],
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Telefone: ',
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700)),
                            TextSpan(
                              text: telefone,
                              style: TextStyle(
                                  fontFamily: "OpensSans",
                                  fontSize: 14,
                                  color: Color(0xFFf0821e)),
                            )],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(onPressed: (){
                            function();
                          }, icon: Icon(Icons.create_outlined)),
                        ],
                      )
                    ]))));
  }
}
