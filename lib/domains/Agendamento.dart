import 'package:ett_app/domains/solicitacao.dart';
import 'horaAgendamento.dart';
class Agendamento {
  int id;
  Solicitacao solicitacao;
  HoraAgendamento horaAgendamento;
  String status;

  Agendamento({this.id,
    this.solicitacao,
    this.horaAgendamento,
    this.status});

  factory Agendamento.fromJson(Map<String, dynamic> json) {
    return Agendamento(
      id: json['id'],
      solicitacao: Solicitacao.fromJson(json['solicitacao']),
      horaAgendamento: HoraAgendamento.fromJson(json['horaAgendamento']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'solicitacao': solicitacao,
    'horaAgendamento': horaAgendamento,
    'status': status,
  };

  Agendamento.vazio(){}
}