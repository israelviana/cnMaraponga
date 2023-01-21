class Voluntario {
  String nome;
  String cpf;
  String telefone;

  Voluntario({this.nome, this.cpf, this.telefone});

  Voluntario.fromJson(Map<String, dynamic> json) {
    nome = json['nome'] ?? "";
    cpf = json['cpf'] ?? "";
    telefone = json['telefone'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['cpf'] = this.cpf;
    data['telefone'] = this.telefone;
    return data;
  }
}