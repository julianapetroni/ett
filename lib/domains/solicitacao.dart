import 'dart:convert';

import 'package:ett_app/domains/Cidade.dart';
import 'package:ett_app/domains/Instituicao.dart';
import 'package:ett_app/domains/TipoSolicitacao.dart';
import 'package:ett_app/domains/Usuario.dart';

class Solicitacao {
  int id;
  Instituicao instituicao = null;
  TipoSolicitacao tipoSolicitacao;
  Usuario cliente;
  Cidade cidade;
  String cpf;
  String rg;
  String rgAcompanhante; //*
  String comprovanteEndereco;
  String declaracaoEscolar;
  String declaracaoRenda1;
  String declaracaoRenda2;
  String declaracaoRenda3;
  String declaracaoRenda4; //nova
  //n tem mais String declaracaoRenda;
  String declaracaoMedica;
  String declaracaoMedica1; //*
  String declaracaoMedica2; //*
  String declaracaoMedica3; //*
  String laudoMedicoOrgaoPublico;
  String cartaoSusFrente; //*
  String cartaoSusVerso; //*
  String bolsista = 'N';
  String comprovanteBolsistaFiesPagina1;
  String comprovanteBolsistaFiesPagina2;
  String comprovanteBolsistaFiesPagina3; //nova
  String comprovanteBolsistaProuniPagina1;
  String comprovanteBolsistaProuniPagina2;
  String comprovanteBolsistaProuniPagina3; //nova
  String comprovanteRevalidacao;
  String fichaFrequencia;
  String numeroCartao;
  String statusSolicitacao;
  String dataProducaoCartao;
  String dataParaRetirada;
  String dataEntregaCartao;
  String dataAgendamento;
  String horaAgendamento;
  String horarioReservado;

  //Array<Documento> documentos;
  String motivoRejeicao;
  String data; //Date
  String status;

  Solicitacao(
      {this.id, this.instituicao, this.tipoSolicitacao, this.cliente, this.cidade, this.cpf, this.rg, this.rgAcompanhante, this.comprovanteEndereco, this.declaracaoEscolar, this.declaracaoRenda1, this.declaracaoRenda2, this.declaracaoRenda3, this.declaracaoRenda4, this.declaracaoMedica, this.declaracaoMedica1, this.declaracaoMedica2, this.declaracaoMedica3, this.laudoMedicoOrgaoPublico, this.cartaoSusFrente, this.cartaoSusVerso, this.bolsista, this.comprovanteBolsistaFiesPagina1, this.comprovanteBolsistaFiesPagina2, this.comprovanteBolsistaFiesPagina3, this.comprovanteBolsistaProuniPagina1, this.comprovanteBolsistaProuniPagina2, this.comprovanteBolsistaProuniPagina3, this.comprovanteRevalidacao, this.fichaFrequencia, this.numeroCartao, this.statusSolicitacao, this.dataProducaoCartao, this.dataParaRetirada, this.dataEntregaCartao, this.motivoRejeicao, this.data, this.status, this.horaAgendamento, this.dataAgendamento, this.horarioReservado});

  factory Solicitacao.fromJson(Map<String, dynamic> json) {
    return Solicitacao(
      id: json['id'],
      instituicao: Instituicao.fromJson(json['instituicao']),
      tipoSolicitacao: TipoSolicitacao.fromJson(json['tipoSolicitacao']),
      cliente: Usuario.fromJson(json['cliente']),
      cidade: Cidade.fromJson(json['cidade']),
      cpf: json['cpf'],
      rg: json['rg'],
      rgAcompanhante: json['rgAcompanhante'],
      comprovanteEndereco: json['comprovanteEndereco'],
      declaracaoEscolar: json['declaracaoEscolar'],
      declaracaoRenda1: json['declaracaoRenda1'],
      declaracaoRenda2: json['declaracaoRenda2'],
      declaracaoRenda3: json['declaracaoRenda3'],
      declaracaoRenda4: json['declaracaoRenda4'],
      declaracaoMedica: json['declaracaoMedica'],
      declaracaoMedica1: json['declaracaoMedica1'],
      declaracaoMedica2: json['declaracaoMedica2'],
      declaracaoMedica3: json['declaracaoMedica3'],
      laudoMedicoOrgaoPublico: json['laudoMedicoOrgaoPublico'],
      cartaoSusFrente: json['cartaoSusFrente'],
      cartaoSusVerso: json['cartaoSusVerso'],
      bolsista: json['bolsista'],
      comprovanteBolsistaFiesPagina1: json['comprovanteBolsistaFiesPagina1'],
      comprovanteBolsistaFiesPagina2: json['comprovanteBolsistaFiesPagina2'],
      comprovanteBolsistaFiesPagina3: json['comprovanteBolsistaFiesPagina3'],
      comprovanteBolsistaProuniPagina1: json['comprovanteBolsistaProuniPagina1'],
      comprovanteBolsistaProuniPagina2: json['comprovanteBolsistaProuniPagina2'],
      comprovanteBolsistaProuniPagina3: json['comprovanteBolsistaProuniPagina3'],
      comprovanteRevalidacao: json['comprovanteRevalidacao'],
      fichaFrequencia: json['fichaFrequencia'],
      numeroCartao: json['numeroCartao'],
      statusSolicitacao: json['statusSolicitacao'],
      dataProducaoCartao: json['dataProducaoCartao'],
      dataParaRetirada: json['dataParaRetirada'],
      dataEntregaCartao: json['dataEntregaCartao'],
      dataAgendamento: json['dataAgendamento'],
      horaAgendamento: json['horaAgendamento'],
      horarioReservado: json['horarioReservado'],
      motivoRejeicao: json['motivoRejeicao'],
      data: json['data'],
      status: json['status'],

    );
  }


  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'instituicao': instituicao,
        'tipoSolicitacao': tipoSolicitacao,
        'cliente': cliente,
        'cidade': cidade,
        'cpf': cpf,
        'rg': rg,
        'rgAcompanhante': rgAcompanhante,
        'comprovanteEndereco': comprovanteEndereco,
        'declaracaoEscolar': declaracaoEscolar,
        'declaracaoRenda1': declaracaoRenda1,
        'declaracaoRenda2': declaracaoRenda2,
        'declaracaoRenda3': declaracaoRenda3,
        'declaracaoRenda4': declaracaoRenda4,
        'declaracaoMedica': declaracaoMedica,
        'declaracaoMedica1': declaracaoMedica1,
        'declaracaoMedica2': declaracaoMedica2,
        'declaracaoMedica3': declaracaoMedica3,
        'laudoMedicoOrgaoPublico': laudoMedicoOrgaoPublico,
        'cartaoSusFrente': cartaoSusFrente,
        'cartaoSusVerso': cartaoSusVerso,
        'bolsista': bolsista,
        'comprovanteBolsistaFiesPagina1': comprovanteBolsistaFiesPagina1,
        'comprovanteBolsistaFiesPagina2': comprovanteBolsistaFiesPagina2,
        'comprovanteBolsistaFiesPagina3': comprovanteBolsistaFiesPagina3,
        'comprovanteBolsistaProuniPagina1': comprovanteBolsistaProuniPagina1,
        'comprovanteBolsistaProuniPagina2': comprovanteBolsistaProuniPagina2,
        'comprovanteBolsistaProuniPagina3': comprovanteBolsistaProuniPagina3,
        'comprovanteRevalidacao': comprovanteRevalidacao,
        'fichaFrequencia': fichaFrequencia,
        'numeroCartao': numeroCartao,
        'statusSolicitacao': statusSolicitacao,
        'dataProducaoCartao': dataProducaoCartao,
        'dataParaRetirada': dataParaRetirada,
        'dataEntregaCartao': dataEntregaCartao,
        'dataAgendamento': dataAgendamento,
        'horaAgendamento': horaAgendamento,
        'horarioReservado': horarioReservado,
        'motivoRejeicao': motivoRejeicao,
        'data': data,
        'status': status,
      };


//HoraAgendamento horaAgendamento;

//  Solicitacao(int id, Instituicao instituicao, TipoSolicitacao tipoSolicitacao, Usuario cliente, Cidade cidade, String cpf, String rg, String rgAcompanhante, String comprovanteEndereco, String declaracaoEscolar,String declaracaoRenda1, String declaracaoRenda2, String declaracaoRenda3, String declaracaoRenda,String declaracaoMedica, String declaracaoMedica1, String declaracaoMedica2, String declaracaoMedica3, String laudoMedicoOrgaoPublico, String cartaoSusFrente, String cartaoSusVerso, String bolsista = 'N', String comprovanteBolsistaFiesPagina1, String comprovanteBolsistaFiesPagina2, String comprovanteBolsistaProuniPagina1, String comprovanteBolsistaProuniPagina2, String comprovanteRevalidacao, String fichaFrequencia, String numeroCartao, String statusSolicitacao, String motivoRejeicao, DateTime data, String status)
//      : this.id = id,
//        this.instituicao = instituicao,
//        this.tipoSolicitacao = tipoSolicitacao,
//        this.cliente = cliente,
//        this.cidade = cidade,
//this.cpf = cpf,
//this.rg = rg,
//this.rgAcompanhante = rgAcompanhante,
//this.comprovanteEndereco = comprovanteEndereco,
//this.declaracaoEscolar = declaracaoEscolar,
//this.declaracaoRenda1 = declaracaoRenda1,
//this.declaracaoRenda2 = declaracaoRenda2,
//this.declaracaoRenda3 = declaracaoRenda3,
//this.declaracaoRenda = declaracaoRenda,
//this.declaracaoMedica = declaracaoMedica,
//this.declaracaoMedica1 = declaracaoMedica1,
//this.declaracaoMedica2 = declaracaoMedica2,
//this.declaracaoMedica3 = declaracaoMedica3,
//this.laudoMedicoOrgaoPublico = laudoMedicoOrgaoPublico,
//this.cartaoSusFrente = cartaoSusFrente,
//this.cartaoSusVerso = cartaoSusVerso,
//this.bolsista = bolsista,
//this.comprovanteBolsistaFiesPagina1 = comprovanteBolsistaFiesPagina1,
//this.comprovanteBolsistaFiesPagina2 = comprovanteBolsistaFiesPagina2,
//this.comprovanteBolsistaProuniPagina1 = comprovanteBolsistaProuniPagina1,
//this.comprovanteBolsistaProuniPagina2 = comprovanteBolsistaProuniPagina2,
//this.comprovanteRevalidacao = comprovanteRevalidacao,
//this.fichaFrequencia = fichaFrequencia,
//this.numeroCartao = numeroCartao,
//this.statusSolicitacao = statusSolicitacao,
////this.documentos = documentos,
//this.motivoRejeicao = motivoRejeicao,
//this.data = data,
//this.status = status
////this.horaAgendamento = horaAgendamento
//  {
//    print("Teste");
//}

  Solicitacao.vazio(){}

}
