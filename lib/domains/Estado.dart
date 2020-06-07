class Estado {
  int id;
  int codigo;
  String sigla;
  String nome;
  String status;

  Estado({this.id, this.codigo, this.sigla, this.nome, this.status});

  factory Estado.fromJson(Map<String, dynamic> json) {
    return Estado(
      id: json['id'],
      codigo: json['codigo'],
      sigla: json['sigla'],
      nome: json['nome'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'codigo': codigo,
    'sigla': sigla,
    'nome': nome,
    'status': status,
  };

  Estado.vazio(){}

}