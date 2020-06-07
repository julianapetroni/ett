class Perfil {
  int id;
  String nome;
  String descricao;
  String status;

  Perfil({this.id, this.nome, this.descricao, this.status});

  factory Perfil.fromJson(Map<String, dynamic> json) {
    return Perfil(
      id: json['id'],
      nome: json['nome'],
      descricao: json['descricao'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'descricao': descricao,
    'status': status,
  };

  Perfil.vazio(){}

}