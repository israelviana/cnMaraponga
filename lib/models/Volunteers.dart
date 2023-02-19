class Voluntario {
  int id;
  String nome;
  String cpf;
  String telefone;

  Voluntario({this.nome, this.cpf, this.telefone, this.id});

  Voluntario.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    nome = json['nome'] ?? "";
    cpf = json['cpf'] ?? "";
    telefone = json['telefone'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['cpf'] = this.cpf;
    data['telefone'] = this.telefone;
    return data;
  }
}