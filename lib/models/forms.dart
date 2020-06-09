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
  String placa = ' ';
  String linha = ' ';
  String sentido = ' ';
  String localAc = ' ';
  String altura = ' ';
  String motorista1 = ' ';
  String matricula1 = ' ';
  String motorista2 = ' ';
  String matricula2 = ' ';


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
        'placa': placa,
        'linha': linha,
        'sentido': sentido,
        'localAc': localAc,
        'altura': altura,
        'motorista1': motorista1,
        'matrmatricula1': matricula1,
        'motorista2': motorista2,
        'matrmatricula2': matricula2
      };
}
