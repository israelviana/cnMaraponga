import 'package:app_transito/core/AppImages.dart';
import 'package:app_transito/router.dart';
import 'package:app_transito/views/Login/CadastroEscalas.dart';
import 'package:flutter/material.dart';

class Inicial extends StatefulWidget{
  const Inicial({Key key}) : super(key: key);

  @override
  State<Inicial> createState() => _Inicial();
}

class _Inicial extends State<Inicial>{
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFF28282b),
      body: Column(
        children: [
          Padding(padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 150),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(AppImages.logoMini),
                ],
              )
            ],
          ),

          ),
          ButtonEscala(),
          SizedBox(height: 30),
          ButtonVeiculos(),
          SizedBox(height: 30),
          ButtonVoluntario()


        ],

      ),
    );
  }
  Widget ButtonEscala(){
    return Container(
        width: 300,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Color(0xFFf0821e),
        ),
        child: InkWell(
          onTap: (){
            Navigator.pushNamed(context, cadastroEscalasRoute);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Escalas",
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

  Widget ButtonVeiculos(){
    return Container(
        width: 300,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Color(0xFFf0821e),
        ),
        child: InkWell(
          onTap: (){
            Navigator.pushNamed(context, cadastroVeiculosRoute);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Veículos",
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

  Widget ButtonVoluntario(){
    return Container(
        width: 300,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Color(0xFFf0821e),
        ),
        child: InkWell(
          onTap: (){
            Navigator.pushNamed(context, cadastroVoluntario);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Volutários",
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
