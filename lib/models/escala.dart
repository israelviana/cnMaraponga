/*class EscalasList{
  List<Escala> listEscala;

  EscalasList({this.listEscala});

  EscalasList.fromJson(Map<String, dynamic> json){
    listEscala = [];
    if(json["Escala"] != null){
      json["Escala"].forEach((v) {
        listEscala.add(new Escala.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Escala'] = this.listEscala.map((e) => e.toJson()).toList();
    return data;
  }

}*/


class Escala{
  String voluntario;
  String data;
  String hora;

  Escala({this.voluntario, this.data, this.hora});

  factory Escala.fromJson(Map<String, dynamic> json) {

   return Escala(
       voluntario: json['voluntario'],
       data: json['data'],
       hora: json['hora'],
   );
  }

  Map<String, dynamic> toJson() {
    return {
      'voluntario': voluntario,
      'data': data,
      'hora': hora
    };
  }
}