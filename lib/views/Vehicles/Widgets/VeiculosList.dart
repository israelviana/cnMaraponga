import 'package:flutter/material.dart';

class VeiculosList extends StatelessWidget {
  VeiculosList(
      {Key key,
        @required this.modelo,
        @required this.cor,
        @required this.placa,
        @required this.condutor,
        @required this.telefone,
        @required this.funcao,

      })
      : super(key: key);

  final modelo, cor, placa, condutor, telefone, funcao;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Container(
            constraints: BoxConstraints(
              minWidth: 358,
              minHeight: size.height * 0.18,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Modelo: ',
                                    style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700
                                    )
                                ),
                                TextSpan(
                                  text: modelo,
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
                                    text: 'Cor: ',
                                    style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700)),
                                TextSpan(
                                  text: cor,
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
                                    text: 'Placa: ',
                                    style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700)),
                                TextSpan(
                                  text: placa,
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
                                    text: 'Condutor: ',
                                    style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700)),
                                TextSpan(
                                  text: condutor,
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
                        ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(onPressed: (){
                          funcao();
                        }, icon: Icon(Icons.create_outlined)),
                      ],
                    )
                  ],
                ))));
  }
}
