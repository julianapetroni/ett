import 'package:ett_app/domains/DataAgendamento.dart';

class HoraAgendamento {
  int id;
  DataAgendamento data;
  String hora;
  String horarioReservado;
  int quantidadeAgendamentos;
  String status;


  HoraAgendamento({this.id, this.data, this.hora, this.horarioReservado, this.quantidadeAgendamentos, this.status});

  factory HoraAgendamento.fromJson(Map<String, dynamic> json) {
    return HoraAgendamento(
      id: json['id'],
      data: DataAgendamento.fromJson(json['data']),
      hora: json['hora'],
      horarioReservado: json['horarioReservado'],
      quantidadeAgendamentos: json['quantidadeAgendamentos'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'data': data,
    'hora': hora,
    'horarioReservado': horarioReservado,
    'quantidadeAgendamentos': quantidadeAgendamentos,
    'status': status,
  };

  HoraAgendamento.vazio(){}
}