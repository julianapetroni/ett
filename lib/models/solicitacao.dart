class Solicitacao {
  int tipoSolicitacaoID;
  int id;
  int instituicaoID;

//  public cliente: Usuario;
//  public cidade: Cidade;
//  public cpf: any;
//  public rg: any;
//  public comprovanteEndereco: any;
//  public declaracaoEscolar: any;
//  public declaracaoRenda1: any;
//  public declaracaoRenda2: any;
//  public declaracaoRenda3: any;
//  public declaracaoRenda4: any;
//  public declaracaoMedica: any;
//  public laudoMedicoOrgaoPublico: any;
//  public cartaoSusFrente: any;
//  public cartaoSusVerso: any;
//  public bolsista = 'N';
//  public comprovanteBolsistaFiesPagina1: any;
//  public comprovanteBolsistaFiesPagina2: any;
//  public comprovanteBolsistaProuniPagina1: any;
//  public comprovanteBolsistaProuniPagina2: any;
//  public comprovanteRevalidacao: any;
//  public fichaFrequencia: any;
//  public numeroCartao: any;
//  public statusSolicitacao: string;
//  public documentos: Array<Documento>;
//  public motivoRejeicao: string;
//  public status = 'ATIVO';

  Solicitacao(int tipoSolicitacaoID, int id, int instituicaoID)
      : this.tipoSolicitacaoID = tipoSolicitacaoID,
        this.id = id,
        this.instituicaoID = instituicaoID {
    //int tipoSolicitacaoID;
    print(tipoSolicitacaoID);
  }
}
