class LoginFormData {
  String email = '';
  String password = '';
  String confirmPassword = '';
  String nome = '';
  String rg = '';
  String cpf = '';
  String telefone = '';
  String cep = '';
  String endereco = '';
  String cidade = '';
  String complemento = '';
  String bairro = '';
  String estado = '';
  String foraDeServico = '';
  String data = '';
  String hora = '';
  String veiculo = '';
  String chapa = '';
  String local = '';
  String descricao = '';
  String mensagem = '';
  String prefixo = ' ';
  String prefixoMonit = ' ';
  String placa = ' ';
  String linha = ' ';
  String sentido = ' ';
  String localAc = ' ';
  String altura = ' ';
  String motorista1 = ' ';
  String matricula = ' ';
  String matricula1 = ' ';
  String motorista2 = ' ';
  String matricula2 = ' ';
  String monitor= ' ';


  Map<String, dynamic> toJSON() => {
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
        'nome': nome,
        'rg': rg,
        'cpf': cpf,
        'telefone': telefone,
        'cep': cep,
        'endereco': endereco,
        'cidade': cidade,
        'complemento': complemento,
        'bairro': bairro,
        'estado': estado,
        'foraDeServico': foraDeServico,
        'data': data,
        'hora': hora,
        'veiculo': veiculo,
        'chapa': chapa,
        'local': local,
        'descricao': descricao,
        'mensagem': mensagem,
        'prefixo': prefixo,
        'prefixoMonit': prefixoMonit,
        'placa': placa,
        'linha': linha,
        'sentido': sentido,
        'localAc': localAc,
        'altura': altura,
        'motorista1': motorista1,
        'matricula': matricula,
        'matricula1': matricula1,
        'motorista2': motorista2,
        'matricula2': matricula2,
        'monitor': monitor
      };
}
