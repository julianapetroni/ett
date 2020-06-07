class TipoSolicitacao {
  int id = 0;
  String nome = '';
  String codigo = '';
  String descricao = '';
  String instituicao = '';
  bool status = true; //ativo

  Map<String, dynamic> toJSON() => {
        'id': id,
        'nome': nome,
        'codigo': codigo,
        'descricao': descricao,
        'instituicao': instituicao,
        'status': status,
      };
}
