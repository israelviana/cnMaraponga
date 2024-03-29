import 'package:flutter/material.dart';

class EscalasListWidget extends StatelessWidget {
  EscalasListWidget(
      {Key key,
        @required this.voluntario,
        @required this.data,
        @required this.hora,
        @required this.function
      })
      : super(key: key);

  final voluntario, data, hora, function;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Container(
            constraints: BoxConstraints(
              minWidth: 358,
              minHeight: size.height * 0.13,
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
                                    text: 'Voluntário: ',
                                    style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700
                                    )
                                ),
                                TextSpan(
                                    text: voluntario,
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
                                    text: 'Data: ',
                                    style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700)),
                                TextSpan(
                                    text: data,
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
                                    text: 'Hora: ',
                                    style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700)),
                                TextSpan(
                                    text: hora,
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
                          function();
                        }, icon: Icon(Icons.create_outlined)),
                      ],
                    )
                  ],
                )
            )));
  }
}
