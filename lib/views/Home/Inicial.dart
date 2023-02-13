import 'package:app_transito/core/AppImages.dart';
import 'package:app_transito/router.dart';
import 'package:app_transito/views/Cadastros/CadastroEscalas.dart';
import 'package:flutter/material.dart';

enum TypeModalInitial{
  modal
}

class Inicial extends StatefulWidget{
  const Inicial({Key key}) : super(key: key);

  @override
  State<Inicial> createState() => _Inicial();
}


class _Inicial extends State<Inicial>{
  final _formKey = GlobalKey<FormState>();
  BuildContext contextModalEscalas;

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF28282b),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
          child: Column(
            children: [
              Image.asset(AppImages.logoAplicativo),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 100),
                child: Container(
                  child: Column(
                    children: [
                      Button("Escalas", "escala"),
                      SizedBox(height: 30),
                      Button("Veículos", "veiculo"),
                      SizedBox(height: 30),
                      Button("Voluntários", "voluntario"),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget Button(String title,String type){
    return Container(
        width: 300,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Color(0xFFf0821e),
        ),
        child: InkWell(
          onTap: (){
            _modal(TypeModalInitial.modal, type);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
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

  Widget ButtonOptions(String texto, String router, BuildContext contextModal){
    return Container(
        width: 300,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Color(0xFFf0821e),
        ),
        child: InkWell(
          onTap: (){
            Navigator.pop(contextModal);
            Navigator.pushNamed(context, router);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                texto,
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

  Widget ContainerModalInitOne(BuildContext context, String titleInit) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
          borderRadius: BorderRadius.only(
            bottomLeft: const Radius.circular(0.0),
            bottomRight: const Radius.circular(0.0),
            topLeft: const Radius.circular(8.0),
            topRight: const Radius.circular(8.0),
          )
      ),
      height: 50,
      child: Stack(
        children: [
          Positioned(
              right: 20,
              top: 12,
              child: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                    child: Icon(
                      Icons.close,
                      color: Color(0xFFf0821e),
                      size: 30,
                    )),
              )
          ),
          Padding(
            padding: EdgeInsets.only(top: 17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(titleInit, style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFFf0821e), fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _modal(TypeModalInitial modal, String type) {
    String titleInitModal = "Opções";
    double heightModal = 344;
    double wightModal = 358;
    showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () {
            Navigator.pop(context);
          },
          child: StatefulBuilder(
            builder: (context, setStateDeletModal) {
              return Dialog(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  backgroundColor: Colors.grey,
                  insetPadding: EdgeInsets.all(8),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                          height: heightModal,
                          width: wightModal,
                          child: Column(
                            children: [
                              ContainerModalInitOne(context, titleInitModal),
                              SizedBox(height: 30),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  type == "escala" ? ButtonOptions("Cadastrar escalas", cadastroEscalasRoute, context) : type == "veiculo" ? ButtonOptions("Cadastrar veículos", cadastroVeiculosRoute, context) : ButtonOptions("Cadastrar voluntário", cadastroVoluntarioRoute, context),
                                  SizedBox(height: 64),
                                  type == "escala" ? ButtonOptions("Visualizar escalas", escalasRoute, context) : type == "veiculo" ? ButtonOptions("Visualizar veículos", veiculosRoute, context) : ButtonOptions("Visualizar voluntário", voluntariosRoute, context),
                                ],
                              ),
                            ],
                          )),
                    ],
                  ));
            },
          ),
        );
      },
    );
  }
}

