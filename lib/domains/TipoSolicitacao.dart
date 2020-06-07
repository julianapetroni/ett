class TipoSolicitacao {
  int id;
  String nome;
  String codigo;
  String descricao;
  String instituicao;
  //String data;
  String status;

  TipoSolicitacao({this.id, this.nome, this.codigo, this.descricao, this.instituicao, this.status});

  factory TipoSolicitacao.fromJson(Map<String, dynamic> json) {
    return TipoSolicitacao(
      id: json['id'],
      nome: json['nome'],
      codigo: json['codigo'],
      descricao: json['descricao'],
      instituicao: json['instituicao'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'codigo': codigo,
    'descricao': descricao,
    'instituicao': instituicao,
    'status': status,
  };

  TipoSolicitacao.init(int id, String nome, String codigo, String descricao, String instituicao, String status)
      :this.id = id,
        this.nome = nome,
        this.codigo = codigo,
        this.descricao = descricao,
        this.instituicao = instituicao,
        this.status = status
  {}
}