import 'dart:convert';

import 'package:ett_app/domains/estado.dart';

class Cidade {

  int id;
  String nome;
  String data;
  Estado estado;
  String status;

  Cidade({this.id, this.nome, this.data, this.estado, this.status});


  factory Cidade.fromJson(Map<String, dynamic> json) {
    return Cidade(
      id: json['id'],
      nome: json['nome'],
      data: json['data'],
      estado: Estado.fromJson(json['estado']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'data': data,
    'estado': estado,
    'status': status,
  };

  Cidade.vazio(){}

}