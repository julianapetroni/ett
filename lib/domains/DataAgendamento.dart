class DataAgendamento {
  int id;
  String data;
  String status;

  DataAgendamento({this.id, this.data, this.status});

  factory DataAgendamento.fromJson(Map<String, dynamic> json) {
    return DataAgendamento(
      id: json['id'],
      data: json['data'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'data': data,
    'status': status,
  };

  DataAgendamento.vazio(){}
}