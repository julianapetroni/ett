//import 'package:flutter/material.dart';
//import 'dart:convert';
//import 'dart:async';
//import 'package:http/http.dart' as http;
//import 'package:pec_login/domains/Agendamento.dart';
//import 'package:pec_login/domains/DataAgendamento.dart';
//import 'package:pec_login/domains/HoraAgendamento.dart';
//import 'package:pec_login/domains/Usuario.dart';
//import 'package:pec_login/domains/solicitacao.dart';
//import 'package:pec_login/screens/status.dart';
//import 'appBarPEC.dart';
//
//class AgendarData extends StatefulWidget {
//
//  Solicitacao sol;
//  Usuario user;
//
//  AgendarData(
//      {Key key,
//        this.sol, this.user})
//      : super(key: key);
//
//  @override
//  AgendarDataState createState() {
//    return AgendarDataState(sol: sol, user: user);
//  }
//}
//
//class AgendarDataState extends State<AgendarData> {
//
//  Solicitacao sol;
//  Usuario user;
//
//  AgendarDataState({this.sol, this.user});
//
//  List<DataAgendamento> _fieldList = List();
//  String _selectedField = null;
//  DataAgendamento daSel;
//  HoraAgendamento haSel;
//  List<HoraAgendamento> _fieldListHora = List();
//  String _selectedFieldHora = null;
//
//  bool _isVisible = false;
//
//  DataAgendamento dataAg;
//  HoraAgendamento horaAg;
//
//  @override
//  void initState() {
//    super.initState();
//    _getFieldsData();
//
//  }
//
//  void printWrapped(String text) {
//    final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
//    pattern.allMatches(text).forEach((match) => print(match.group(0)));
//  }
//  _agendar(String data, String hora) {
//
//    print(user.id);
//    sol.statusSolicitacao = 'AGENDADA';
//    print(sol.statusSolicitacao);
////    sol.data = data + "T" + hora;
////    DataAgendamento da = new DataAgendamento.vazio();
////    da.data = data;
////    HoraAgendamento ha = new HoraAgendamento.vazio();
////    ha.hora = hora;
//
//    sol.cpf = "";
//    sol.rg = "";
//    sol.rgAcompanhante = "";
//    sol.comprovanteEndereco = "";
//    sol.declaracaoEscolar = "";
//    sol.declaracaoRenda1 = "";
//    sol.declaracaoRenda2 = "";
//    sol.declaracaoRenda3 = "";
//    sol.declaracaoRenda4 = "";
//    sol.declaracaoMedica = "";
//    sol.declaracaoMedica1 = "";
//    sol.declaracaoMedica2 = "";
//    sol.declaracaoMedica3 = "";
//    sol.laudoMedicoOrgaoPublico = "";
//    sol.cartaoSusFrente = "";
//    sol.cartaoSusVerso = "";
//    sol.bolsista = "";
//    sol.comprovanteBolsistaFiesPagina1 = "";
//    sol.comprovanteBolsistaFiesPagina2 = "";
//    sol.comprovanteBolsistaFiesPagina3 = "";
//    sol.comprovanteBolsistaProuniPagina1 = "";
//    sol.comprovanteBolsistaProuniPagina2 = "";
//    sol.comprovanteBolsistaProuniPagina3 = "";
//    sol.comprovanteRevalidacao = "";
//    sol.fichaFrequencia = "";
//    sol.numeroCartao = "";
//
//    Agendamento agendamento = new Agendamento.vazio();
//    agendamento.solicitacao = sol;
//    agendamento.id = sol.id;
//    agendamento.horaAgendamento = haSel;
//
//    agendamento.status = 'ATIVO';
//    String url = 'https://www.accio.com.br:447/api/v1/solicitacoes/scheduller';
//    Map<String, dynamic> map = agendamento.toJson();
//    String body = jsonEncode(map);
//    printWrapped(body);
//
//    http
//        .put(url,
//        headers: {
//          'Content-Type':
//          'application/json',
//          'Authorization':
//          'bearer d16e3966-eb87-4337-bfee-bee54b5a4052'
//        }, body: body).then((response) {
//      print("Response status: ${response.statusCode}");
//      //print("Response body: ${response.contentLength}");
//      // print(response.headers);
//      print(response.body);
//
//      if (response.statusCode == 200) {
//        print("PASSOU");
//
//        Navigator.push(
//            context,
//            MaterialPageRoute(
//              builder: (context) => Status(user: user/*, ha: haSel*/),
//            ));
//        Navigator.of(context).pushAndRemoveUntil(
//            MaterialPageRoute(builder: (context) =>
//                Status(user: user)),
//                (Route<dynamic> route) => false);
//      }});
//  }
//
//  Future<String> _getDropDownData() async {
//    var res = await http.get('https://www.accio.com.br:447/api/v1/agendamentos/datasAgendamentos/datas/?access_token=d16e3966-eb87-4337-bfee-bee54b5a4052');
//    print(res.body);
////    var list = json.decode((res.body)) as List;
////    Iterable l =json.decode((res.body));
////    List<DataAgendamento> teste = list.map((i)=> DataAgendamento.fromJson(i)).toList();
//    //print(teste[0].data);
//    //teste de lista jogando a data na tela
//
//    //dataAg = DataAgendamento.fromJson(jsonDecode(res.body));
//    // print(dataAg.id);
//    return res.body;
//  }
//
//  Future<String> _getDropDownHora(int id) async {
//    var res = await http.get(Uri.encodeFull('https://www.accio.com.br:447/api/v1/agendamentos/horasAgendamentos/horarios/nao-reservadas/' + id.toString() + '/?access_token=d16e3966-eb87-4337-bfee-bee54b5a4052'));
//    return res.body;
//  }
//
//
//  // map data to list
//  void _getFieldsData() {
//    _getDropDownData().then((data) {
//      final items = jsonDecode(data).cast<Map<String, dynamic>>();
//      var fieldListData = items.map<DataAgendamento>((json) {
//        return DataAgendamento.fromJson(json);
//      }).toList();
//      _selectedField = fieldListData[0].data;
//
//      // update widget
//      if(mounted) {
//        setState(() {
//          _fieldList = fieldListData;
//        });
//      }
//    });
//  }
//
//
//  void _getFieldsHora(int id) {
//    _getDropDownHora(id).then((hora) {
//      final items = jsonDecode(hora).cast<Map<String, dynamic>>();
//      var fieldListHora = items.map<HoraAgendamento>((json) {
//        return HoraAgendamento.fromJson(json);
//      }).toList();
//      _selectedFieldHora = fieldListHora[0].hora;
//
//      // update widget
//      setState(() {
//        _fieldListHora = fieldListHora;
//      });
//    });
//  }
//
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        backgroundColor: Colors.white,
//        appBar: AppBarPEC(
//          title: Text(' '),
//        ),
//        endDrawer: MyDrawer(user: user),
//        body: Stack(
//            children: <Widget>[
//              Container(
//                margin: EdgeInsets.only(top: 30.0),
//                child: Column(
//                  children: <Widget>[
//                    Flexible(
//                      flex: 2,
//                      child: Center(
//                        child: Image(
//                          image: AssetImage('images/PECLogo.png'),
//                          //height: 100.0,
//                        ),
//                      ),
//                    ),
//                    SizedBox(height: 40.0,),
//                    Flexible(
//                      flex: 2,
//                      child: Container(
//                        child: Column(
//                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: <Widget>[
//                            Padding(
//                              padding: const EdgeInsets.fromLTRB(30, 0, 20, 10),
//                              child: Row(children: <Widget>[
//                                Icon(Icons.calendar_today, color: Colors.grey),
//                                SizedBox(width: 40.0),
//                                const Text('Datas disponíveis',
//                                    style: TextStyle(
//                                        fontSize: 18,
//                                        color: Colors.grey,
//                                        fontWeight: FontWeight.bold))
//                              ]),
//                            ),
//                            Padding(
//                              padding: const EdgeInsets.only(top: 20.0, left: 40.0, right: 40.0),
//                              child: Container(
//                                color: Colors.grey[100],
//                                child: DropdownButton<DataAgendamento>(
//                                  items: _fieldList.map((DataAgendamento da) {
//                                    return DropdownMenuItem<DataAgendamento>(
//                                      value: da,
//                                      child: Row(
//
//                                        mainAxisAlignment: MainAxisAlignment.center,
//                                        children: <Widget>[
//                                          Text(da.data, style: TextStyle(
//                                            fontSize: 18,
//                                            color: Colors.grey[700],
//
//                                          ),),
//                                        ],
//                                      ),
//                                    );
//                                  }).toList(),
//                                  value: daSel,
//                                  onChanged: (value) {
//                                    daSel = value;
//                                    print(daSel.data);
//                                    _selectedField = daSel.data;
//
//
//                                    if( _selectedField != null){
//                                      _isVisible = true;
//                                      _getFieldsHora(value.id);//id nao foi passado com sucesso
//                                    }
//
//                                    setState(() {
//                                      //_selectedField = value;
//                                    });
//                                  },
//                                  isExpanded: true,
//                                  hint: new Text('Selecione uma data'),
//
//                                ),
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),),
//                    Visibility(
//                      visible: _isVisible,
//
//                      child: Flexible(
//                        flex: 3,
//                        child: Container(
//                          child: Column(
//                            children: <Widget>[
//                              Padding(
//                                padding: const EdgeInsets.fromLTRB(30, 0, 0, 10),
//                                child: Row(children: <Widget>[
//                                  Icon(Icons.timer, color: Colors.grey),
//                                  SizedBox(width: 40.0),
//                                  const Text('Horários disponíveis',
//                                      style: TextStyle(
//                                          fontSize: 18,
//                                          color: Colors.grey,
//                                          fontWeight: FontWeight.bold))
//                                ]),
//                              ),
//                              Padding(
//                                padding: const EdgeInsets.only(top: 20.0, left: 40.0, right: 40.0),
//                                child: Container(
//                                  color: Colors.grey[100],
//                                  child: DropdownButton<HoraAgendamento>(
//                                    items: _fieldListHora.map((HoraAgendamento ha) {
//                                      return DropdownMenuItem<HoraAgendamento>(
//                                        value: ha,
//                                        child: Row(
//                                          mainAxisAlignment: MainAxisAlignment.center,
//                                          children: <Widget>[
//                                            Text(ha.hora, style: TextStyle(
//                                              fontSize: 18,
//                                              color: Colors.grey[700],
//                                            ),),
//                                          ],
//                                        ),
//                                      );
//                                    }).toList(),
//                                    value: haSel,
//                                    onChanged: (value) {
//                                      haSel = value;
//
//                                      //_selectedFieldHora = value;
//                                      setState(() {
//                                        _selectedFieldHora = haSel.hora;
//                                      });
//                                      print(_selectedFieldHora);
//                                    },
//                                    isExpanded: true,
//                                    hint: Text('Selecione um horário'),
//                                  ),
//                                ),
//                              ),
//                            ],
//                          ),
//                        ),),
//                    )
//                  ],
//                ),
//              ),
//            ]),
//        floatingActionButton: Padding(
//          padding: const EdgeInsets.only(left: 30.0),
//          child: Container(
//            height: 70,
//            width: double.infinity,
//            //alignment: Alignment.center,
//            color: Colors.white,
//            child: Column(
//              children: <Widget>[
//                FlatButton(
//                  onPressed: () {
//                    _agendar(_selectedField, _selectedFieldHora);
////                    Navigator.push(
////                        context,
////                        MaterialPageRoute(
////                          builder: (context) => StatusFinal(),
////                        ));
////                    Navigator.of(context).pushAndRemoveUntil(
////                        MaterialPageRoute(builder: (context) => StatusFinal(
////                          // user: usuario
////                        )),
////                            (Route<dynamic> route) => false);
//                  },
//                  textColor: Colors.white,
//                  color: Colors.white,
//                  child: Container(
//                    width: double.infinity,
//                    height: 45.0,
//                    decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(15.0),
//                      gradient: LinearGradient(
//                        colors: <Color>[
//                          Color(0xFF33691E),
//                          Color(0xFF689F38),
//                          Color(0xFF8BC34A),
//                        ],
//                      ),
//                    ),
//                    child: Center(
//                        child: const Text('AGENDAR',
//                            style: TextStyle(fontSize: 20))),
//                  ),
//                ),
//              ],
//            ),
//
//          ),
//        )
//    );
//  }
//}