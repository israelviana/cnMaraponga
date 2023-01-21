class Veiculo{
  String modelo;
  String cor;
  String placa;
  String condutor;
  String telefone;

  Veiculo({this.modelo, this.cor, this.placa, this.condutor, this.telefone});

  Veiculo.fromJson(Map<String, dynamic> json) {
    modelo = json['modelo'] ?? "";
    cor = json['cor'] ?? "";
    placa = json['placa'] ?? "";
    condutor = json['condutor'] ?? "";
    telefone = json['telefone'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['modelo'] = this.modelo;
    data['cor'] = this.cor;
    data['placa'] = this.placa;
    data['condutor'] = this.condutor;
    data['telefone'] = this.telefone;
    return data;
  }
}