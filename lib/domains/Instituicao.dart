class Instituicao {
  int id = null;
  String nome= null;

  Instituicao({this.id, this.nome});

  factory Instituicao.fromJson(Map<String, dynamic> json) {
      return null;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
  };

}