import 'dart:convert';

import 'package:ett_app/domains/cidade.dart';
import 'package:ett_app/domains/estado.dart';
import 'package:ett_app/domains/perfil.dart';

class Usuario {
  int id;
  String nome;
  String cpf;
  String endereco;
  String complemento;
  String bairro;
  Cidade cidade;
  Estado estado;
  String cep;
  String contato;// = null;
  String email;
  String observacao;
  Perfil perfil; //??
  String status;// = "ATIVO";
  String senha;
  String resetSenha;//= "N";
  String prefixo;


  Usuario({this.id, this.nome, this.cpf, this.endereco, this.complemento, this.bairro, this.cidade, this.estado, this.cep, this.contato, this.email ,this.observacao, this.perfil, this.status, this.senha, this.resetSenha, this.prefixo});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nome: json['nome'],
      cpf: json['cpf'],
      endereco: json['endereco'],
      complemento: json['complemento'],
      bairro: json['bairro'],
      cidade: Cidade.fromJson(json['cidade']),
      estado: Estado.fromJson(json['estado']),
      cep: json['cep'],
      contato: json['contato'],
      email: json['email'],
      observacao: json['observacao'],
      perfil: Perfil.fromJson(json['perfil']),
      status: json['status'],
      senha: json['senha'],
      resetSenha: json['resetSenha'],
      prefixo: json['prefixo'],

    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'cpf': cpf,
    'endereco': endereco,
    'complemento': complemento,
    'bairro': bairro,
    'cidade': cidade,
    'estado': estado,
    'cep': cep,
    'contato': contato,
    'email': email,
    'observacao': observacao,
    'perfil': perfil,
    'status': status,
    'senha': senha,
    'resetSenha': resetSenha,
    'prefixo': prefixo,
  };

  Usuario.vazio(){}

}