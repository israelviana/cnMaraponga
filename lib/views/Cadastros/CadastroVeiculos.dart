
import 'package:app_transito/models/veiculos.dart';
import 'package:app_transito/services/ScalffoldMensage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CadastroVeiculos extends StatefulWidget{
  const CadastroVeiculos({Key key}) : super(key: key);


  State<CadastroVeiculos> createState() => _CadastroVeiculos();
}

class _CadastroVeiculos extends State<CadastroVeiculos>{
  final _formkey = GlobalKey<FormState>();
  final modeloController = TextEditingController(text: '');
  final corController = TextEditingController(text: '');
  final placaController = TextEditingController(text: '');
  final condutorController = TextEditingController(text: '');
  final telefoneController = TextEditingController(text: '');

  var listVeiculo;

  var _scaffoldKeyLogIn;

  @override
  void initState(){
    _getVeiculoList();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      key: _scaffoldKeyLogIn,
      backgroundColor: Color(0xFF28282b),
      body: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 40),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /*Image.asset(
                        AppImages.logoMini),*/
                    Text("Cadastro de Veículos",
                      style: TextStyle(
                          fontFamily: "OpensSans",
                          fontSize: 28,
                          color: Color(0xFFf0821e)
                      ),
                    ),
                  ],
                ),
                ButtonVeiculos()
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }

  Widget ButtonVeiculos(){
    return Form(
      key: _formkey,
      child: Padding(
        padding: const EdgeInsets.only(top: 35),
        child: Column(
          children: [
            Text(
              "Modelo:",
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 24,
                color: Color(0xFFf0821e),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: _InputForm(modeloController, 'MODELO', 'Modelo'),
            ),
            Text(
              "Cor: ",
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 24,
                  color: Color(0xFFf0821e)
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 10),
              child: _InputForm(corController, 'COR', 'Cor'),
            ),
            Text(
              "Placa: ",
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 24,
                  color: Color(0xFFf0821e)
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 10),
              child: _InputForm(placaController, 'PLACA', 'Placa'),
            ),
            SizedBox(height: 20),
            Text(
              "Condutor: ",
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 24,
                  color: Color(0xFFf0821e)
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 10),
              child: _InputForm(condutorController, 'CONDUTOR', 'Condutor'),
            ),
            SizedBox(height: 20),
            Text(
              "Telefone: ",
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 24,
                  color: Color(0xFFf0821e)
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 10),
              child: _InputForm(telefoneController, 'TELEFONE', 'Telefone'),
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
        hintStyle: TextStyle(
            color: Colors.white70
        ),
      ),
      style: TextStyle(
          color: Colors.white70
      ),
      validator: (value) {
        switch (title) {
          case "MODELO":
            if (value.isEmpty) {
              return "Favor preencher o campo modelo.";
            }
            return null;
          case "COR":
            if (value.isEmpty) {
              return "Favor preencher o campo cor.";
            }
            return null;
          case "PLACA":
            if (value.isEmpty){
              return "Favor preencher o campo placa.";
            }
            return null;
          case "CONDUTOR":
            if (value.isEmpty){
              return "Favor preencher o campo condutor.";
            }
            return null;
          case "TELEFONE":
            if (value.isEmpty){
              return "Favor preencher o campo telefone.";
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
          if (_formkey.currentState.validate()) {
            _adicionarList();
          }
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

  void _adicionarList(){
    Veiculo veiculo = new Veiculo(
      condutor: condutorController.text,
      cor: corController.text,
      modelo: modeloController.text,
      placa: placaController.text,
      telefone: telefoneController.text
    );

    listVeiculo.add(veiculo);
    _saveVeiculoList(listVeiculo);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        dismissDirection: DismissDirection.down,
        elevation: 5,
        behavior: SnackBarBehavior.floating,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                child: Text("Veículo cadastrado com sucesso!!"))
          ],
        ),
        backgroundColor:  Color(0xFF4FBD2D),
      ),
    );
    Future.delayed(Duration(milliseconds: 800)).then((_) async {
      Navigator.pop(context);
    });
  }

  Future<void> _saveVeiculoList(List<Veiculo> veiculoList) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setVeiculoList("listVeiculo", veiculoList);
  }

  _getVeiculoList() async {
    listVeiculo = await loadVeiculoList();
  }

  Future<List<Veiculo>> loadVeiculoList() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getVeiculoList("listVeiculo") ?? [];
  }



}