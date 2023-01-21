class EscalasList{
  List<Escala> listEscala;

  EscalasList({this.listEscala});

  EscalasList.fromJson(List<dynamic> json){
    listEscala = [];
    json.forEach((element) {
      listEscala.add(new Escala.fromJson(element));
    });
  }
}


class Escala{
  String voluntario;
  String data;
  String hora;

  Escala({this.voluntario, this.data, this.hora});

  Escala.fromJson(Map<String, dynamic> json) {
    voluntario = json['voluntario'] ?? "";
    data = json['data'] ?? "";
    hora = json['hora'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['voluntario'] = this.voluntario;
    data['data'] = this.data;
    data['hora'] = this.hora;
    return data;
  }
}