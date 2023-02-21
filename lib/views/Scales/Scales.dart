
import 'package:app_transito/router.dart';
import 'package:app_transito/views/Scales/Widgets/EscalasListWidget.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../../components/inputForm.dart';
import '../../database/db.dart';
import '../../models/Scales.dart';


enum typeModal{
  modal
}

class Scales extends StatefulWidget {
  const Scales({Key key}) : super(key: key);

  @override
  State<Scales> createState() => _ScalesState();
}


class _ScalesState extends State<Scales> {
  Future requisitionEscalas;
  List<Escala> listEscala = <Escala>[];

  final nomeController = TextEditingController(text: '');
  String nome;


  @override
  void initState(){
    _carregarEscalas();
    nomeController.text = "";
  }


  void _carregarEscalas() async{
    final database = await DB.instance.database;
    List<Map<String, dynamic>> escalas = await database.query('escalas');
    setState(() {
      listEscala = escalas.map((escala) => Escala(id: escala['id'], voluntario:  escala['nome'], data: escala['data'], hora: escala['hora'])).toList();
    });
    database.close();
  }

  _buscarVoluntario(String nome) async{
    final database = await DB.instance.database;
    List<Map<String, dynamic>> escalas = await database.rawQuery('SELECT * FROM escalas WHERE nome LIKE "%$nome%"');
    setState(() {
      listEscala = escalas.map((escala) => Escala(id: escala['id'], voluntario:  escala['nome'], data: escala['data'], hora: escala['hora'])).toList();
    });
    database.close();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF28282b),
        body: RefreshIndicator(
          onRefresh: () => Future.delayed(Duration(milliseconds: 500), () => initState()),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                  delegate: SliverChildListDelegate([
                    Column(
                      children: [
                        SizedBox(height: 20),
                        Text("ESCALAS", style: TextStyle(
                            fontFamily: "OpensSans",
                            fontSize: 40,
                            color: Color(0xFFf0821e)
                        )),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Flexible(child: InputForm(title: 'Digite o VOLUNTARIO pelo qual deseja buscar', type: "TEXT", controller: nomeController)),
                              InkWell(
                                onTap: (){
                                  nome = nomeController.text;
                                  if(nome == ""){
                                    initState();
                                  }else{
                                    _buscarVoluntario(nome);
                                  }
                                },
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFf0821e)
                                  ),
                                  child: Icon(Icons.search),
                                ),
                              )
                            ],
                          ),
                        ),
                        listEscala.length == 0 ? Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Center(child: Text("Não possui dados de escalas!!!", style: TextStyle(
                              fontFamily: "OpensSans",
                              fontSize: 20,
                              color: Color(0xFFf0821e)
                          ))),
                        ) :
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: listEscala.length,
                              itemBuilder: (BuildContext context, int index){
                                return EscalasListWidget(voluntario: listEscala[index].voluntario, data: listEscala[index].data, hora: listEscala[index].hora, function: () => _modal(typeModal.modal, listEscala[index].id.toString()),);
                              }
                          ),
                        ),
                      ],
                    ),
                  ]))
            ],
          ),
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

  _modal(typeModal type, String id) {
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
                                  ButtonOptions("Excluir escala", () => _excluirEscala(id)),
                                  SizedBox(height: 64),
                                  ButtonOptions("Editar escala", () => Navigator.popAndPushNamed(context, editScalesRoute, arguments: id)),
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

  _excluirEscala(String id) async{
    final database = await openDatabase('cnMaraponga.db');

    await database.delete('escalas', where: '"id" = ?', whereArgs: ['$id']);

    initState();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        dismissDirection: DismissDirection.down,
        elevation: 5,
        behavior: SnackBarBehavior.floating,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                child: Text("Escala excluida com sucesso!"))
          ],
        ),
        backgroundColor:  Color(0xFF4FBD2D),
      ),
    );
    database.close();
  }

  Widget ButtonOptions(String texto, Function funcao){
    return Container(
        width: 300,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Color(0xFFf0821e),
        ),
        child: InkWell(
          onTap: (){
            Navigator.pop(context);
            funcao();
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

}


