//import 'dart:convert';
//import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
//import 'package:flutter/material.dart';
//import 'package:pec/domains/dataAgendamento.dart';
//import 'package:pec/domains/solicitacao.dart';
//import 'package:pec/domains/tipoSolicitacao.dart';
//import 'package:pec/screens/login.dart';
//import 'package:pec/domains/usuario.dart';
//import 'package:pec/models/forms.dart';
//import 'package:pec/screens/status.dart';
//import 'package:pec/utils/validators.dart';
//import 'package:http/http.dart' as http;
//import 'package:flutter/cupertino.dart';
//import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
//import 'package:intl/intl.dart';
//import 'dart:async';
//import 'package:pec/domains/extratoCartao.dart';
//
//import 'appBarPEC.dart';
//
//class ExtratoCartao extends StatefulWidget {
//  Usuario user;
//  Token token;
//  Solicitacao sol;
//
//  ExtratoCartao(
//      {Key key,
//        // this.value,
//        this.user,
//        this.token,
//        this. sol})
//      : super(key: key);
//
//  @override
//  ExtratoCartaoState createState() =>
//      new ExtratoCartaoState(user: user, token: token, sol: sol);
//}
//
//class ExtratoCartaoState extends State<ExtratoCartao> {
//  Usuario user;
//  Token token;
//  Solicitacao sol;
//
//  ExtratoCartaoState({this.user, this.token, this.sol});
//
//
//
//
//  List<DataAgendamento> _fieldList = List();
//  String _selectedField = null;
//  DataAgendamento daSel;
//  DataAgendamento dataAg;
//
//  String _mySelection;
//
//  int idTipoSolicitacao;
//
//  List<TipoSolicitacao> _fieldListTipoSolicitacao = List();
//  String _selectedFieldTipoSolicitacao = null;
//  TipoSolicitacao tipoSolicitacaoSel;
//
//  bool _tipoSolicitacaoSelecionada = false;
//
//
//  bool _isChecked = false;
//
//  var maskFormatter = new MaskTextInputFormatter(
//      mask: '##.##.########.#', filter: {"#": RegExp(r'[0-9]')});
//
//  void onChanged(bool value) {
//    setState(() {
//      _isChecked = value;
//    });
//  }
//
//  final _scaffoldKey = GlobalKey<ScaffoldState>();
//
//  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//  final GlobalKey<FormFieldState<String>> _nomeKey =
//  GlobalKey<FormFieldState<String>>();
//  final GlobalKey<FormFieldState<String>> _numeroCartaoKey =
//  GlobalKey<FormFieldState<String>>();
//  final GlobalKey<FormFieldState<String>> _tipoSolicitacaoKey =
//  GlobalKey<FormFieldState<String>>();
//
//  LoginFormData _loginData = LoginFormData();
//  bool _autovalidate = true;
//
//  final _nomeController = TextEditingController();
//  final _numeroCartaoController = TextEditingController();
//  final _tipoSolcitacaoController = TextEditingController();
//
//  List<dynamic> _tipoSolicitacao = [];
//
//  String _dropdownError;
//
//
////  _validateForm() {
////    bool _isValid = _formKey.currentState.validate();
////
////    if (_mySelection == null) {
////      setState(() => _dropdownError = "Selecione uma opção!");
////      _isValid = false;
////    }
////
////    if (_isValid) {
////      //form is valid
////    }
////  }
//
//
//  _validateForm() {
//    bool _isValid = _formKey.currentState.validate();
//
//    if (mostrarDataSelecionada == false) {
//      setState(() => _dropdownError = "Selecione o período do extrato!");
//      _isValid = false;
//    } else{
//      setState(() => _dropdownError = " ");
//
//    }
//
//    if (_isValid) {
//      //form is valid
//    }
//  }
//
//
//  ExtratoDoCartao extratoDoCartao;
//  //String numeroCartao;
//  String extrato = '';
//  List<dynamic> _extratoCartao = [];
//
//  void _fetchCartaoExtrato() async {
//    var response = await http.get(
//      'http://app.cartaopec.com.br/api/v1/pedidosExtratos?access_token=' + token.access_token.toString(),
////    'http://app.cartaopec.com.br/api/v1/usuarios/userinfo?access_token=' + token.access_token.toString(),
//      headers: {"Accept": "application/json"},);
//    print(token.access_token.toString());
//    //print('$numeroCartao');
//
//
//    if (response.statusCode == 200) {
//
//      _extratoCartao = json.decode(response.body);
//
//      print('quantidade ${_extratoCartao.length}');
//      // print(list.toString());
//      setState(() {
//        //print('UI Updated');
//      });
//    } else {
//      print('Usuário sem cartão : ${response.statusCode}');
//    }
//  }
//
//  Future<String> _getDropDownTipoSolicitacao() async {
//    var res = await http.get(
//        'http://app.cartaopec.com.br/api/v1/tiposSolicitacoes?access_token=' +
//            token.access_token.toString());
//    return res.body;
//  }
//
//  void _getFieldsTipoSolicitacao() {
//    _getDropDownTipoSolicitacao().then((nome) {
//      final items = jsonDecode(nome).cast<Map<String, dynamic>>();
//      var fieldListTipoSolicitacao = items.map<TipoSolicitacao>((json) {
//        return TipoSolicitacao.fromJson(json);
//      }).toList();
//      _selectedFieldTipoSolicitacao = fieldListTipoSolicitacao[0].nome;
//
//      // update widget
//      if (mounted) {
//        setState(() {
//          _fieldListTipoSolicitacao = fieldListTipoSolicitacao;
//        });
//      }
//    });
//  }
//
//
//  Future<String> _getDropDownData() async {
//    var res = await http.get('http://app.cartaopec.com.br/api/v1/agendamentos/datasAgendamentos/datas/?access_token=' + token.access_token.toString());
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
//  @override
//  initState() {
//    super.initState();
//    _getFieldsTipoSolicitacao();
//    this._fetchCartaoExtrato();
//  }
//
//  @override
//  dispose() {
//    _nomeController.dispose();
//    _numeroCartaoController.dispose();
//    _tipoSolcitacaoController.dispose();
//
//    super.dispose();
//  }
//
//  // Initially password is obscure
//  bool _obscureText = true;
//
//  // Toggles the password show status
//  void _toggle() {
//    setState(() {
//      _obscureText = !_obscureText;
//    });
//  }
//
//  // Período
//  DateTime _dateTime;
//  bool mostrarDataSelecionada = false;
//  bool mostrarSelecionePeriodo = true;
//  DateTime _startDate = DateTime.now().subtract(Duration (days: 15));
//  DateTime _endDate = DateTime.now();
//  //.add(Duration(days: 7));
//
//  Future displayDateRangePicker(BuildContext context) async {
//    final List<DateTime> picked = await DateRagePicker.showDatePicker(
//      context: context,
//      initialFirstDate: _startDate,
//      initialLastDate: _endDate,
//      firstDate: new DateTime(DateTime.now().year - 2),
//      lastDate: new DateTime.now().subtract(Duration (days: 0)),
//      //new DateTime(DateTime.now().year + 1)
////      builder: (context, child){
////          return SingleChildScrollView(child: child,);
////      }
//
//    );
//    if (picked != null && picked.length == 2) {
//      setState(() {
//        _startDate = picked[0];
//        _endDate = picked[1];
//      });
//    }
//  }
//
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      key: _scaffoldKey,
//      appBar: AppBarPEC(user: user, token: token, sol: sol),
//      backgroundColor: Colors.white,
//      body: SafeArea(
//          child: Padding(
//            padding: const EdgeInsets.only(top: 20.0),
//            child: ListView(
//              children: <Widget>[
//                Padding(
//                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                  child: Form(
//                    key: _formKey,
//                    autovalidate: _autovalidate,
//                    child: Column(
//                      mainAxisAlignment: MainAxisAlignment.spaceAround,
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      children: <Widget>[
//                        Container(
//                          height: 80.0,
//                          width: double.infinity,
//                          child: Center(
//                            child: Row(
//                              mainAxisAlignment: MainAxisAlignment.center,
//                              children: <Widget>[
//                                Image(
//                                  image: AssetImage('images/PECLogo.png'),
//                                ),
//                              ],
//                            ),
//                          ),
//                        ),
//                        SizedBox(height: 30.0),
//                        Padding(
//                          padding:
//                          const EdgeInsets.only(left: 20.0, top: 10.0),
//                          child: Row(
//                            children: <Widget>[
//                              Text("Extrato do Cartão",
//                                  textAlign: TextAlign.start,
//                                  style: TextStyle(
//                                      fontSize: 22.0,
//                                      color: Colors.green,
//                                      fontFamily: "Poppins-Bold",
//                                      letterSpacing: .6)),
//                            ],
//                          ),
//                        ),
//                        SizedBox(
//                          height: 30.0,
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.only(
//                              left: 20.0, right: 20.0, bottom: 10.0),
//                          child: Column(
//                            children: <Widget>[
//                              Row(
//                                children: <Widget>[
//                                  Icon(
//                                    Icons.person,
//                                    color: Colors.grey[400],
//                                    size: 19.0,
//                                  ),
//                                  SizedBox(
//                                    width: 10.0,
//                                  ),
//                                  Text(
//                                    'Nome',
//                                    style:
//                                    TextStyle(color: Colors.grey[500]),
//                                  ),
//                                ],
//                              ),
//                              TextFormField(
//                                key: _nomeKey,
//                                controller: TextEditingController(text: '${user.nome}'),
//                                validator: composeValidators('o nome',
//                                    [requiredValidator, stringValidator]),
//                                onSaved: (value) => _loginData.nome = value,
//                                decoration: InputDecoration(hintText: ' '),
//                              ),
//                            ],
//                          ),
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.only(
//                              left: 20.0, right: 20.0, top: 20.0),
//                          child: Stack(
//                            children: <Widget>[
//                              Row(
//                                children: <Widget>[
//                                  Icon(
//                                    Icons.timer,
//                                    color: Colors.grey[400],
//                                    size: 19.0,
//                                  ),
//                                  SizedBox(
//                                    width: 10.0,
//                                  ),
//                                  Text(
//                                    'Período',
//                                    style:
//                                    TextStyle(color: Colors.grey[500]),
//                                  ),
//                                ],
//                              ),
//
//                              Theme(
//                                data:
//
//                                Theme.of(context).copyWith(
//                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                                  colorScheme: ColorScheme.light(
//                                    primary: Colors.lightGreen[800],
//                                  ),
//                                  primaryColorBrightness: Brightness.light,
//                                  primaryColor: Colors.lightGreen[100], //color of the main banner
//                                  accentColor: Colors.lightGreen[300], //color of circle indicating the selected date
//                                  buttonTheme: ButtonThemeData(
//                                      textTheme: ButtonTextTheme.accent //color of the text in the button "OK/CANCEL"
//                                  ),
//                                ),
//                                child: Builder(
//                                    builder: (context){
//                                      return Padding(
//                                        padding: const EdgeInsets.only( top: 30.0),
//                                        child: Container(
//                                          //margin: const EdgeInsets.all(30.0),
//                                          padding: const EdgeInsets.all(0.0),
//                                          decoration: BoxDecoration(
//                                            border: Border(
//                                              bottom: BorderSide(
//                                                color: Colors.grey,
//                                                width: 1.0,
//                                              ),
//                                            ),
//                                          ), //       <--- BoxDecoration here
//                                          child: Row(
//                                            children: <Widget>[
//                                              FlatButton(
//                                                child: Row(
//                                                  children: <Widget>[
//                                                    Visibility(
//                                                      visible: mostrarDataSelecionada,
//                                                      child: Padding(
//                                                        padding: const EdgeInsets.only(top: 8),
//                                                        child: Row(
//                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                                          children: <Widget>[
//                                                            Text("De ${DateFormat('dd/MM/yyyy').format(_startDate).toString()}", style: TextStyle(color: Colors.grey[800], fontSize: 15),),
//                                                            //Text(" ", style: TextStyle(color: Colors.green[700])),
//                                                            Text(" a ${DateFormat('dd/MM/yyyy').format(_endDate).toString()}", style: TextStyle(color: Colors.grey[800], fontSize: 15)),
//                                                          ],
//                                                        ),
//                                                      ),
//                                                    ),
//                                                    Visibility(
//                                                        visible: mostrarSelecionePeriodo,
//                                                        child: Text("Selecione o período", style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.normal),)),
//                                                  ],
//                                                ),
//                                                onPressed: () async {
//                                                  mostrarDataSelecionada = true;
//                                                  mostrarSelecionePeriodo = false;
//                                                  _dropdownError = " ";
//                                                  await displayDateRangePicker(context);
//                                                },
//                                              ),
//                                            ],
//                                          ),
//                                        ),
//
//
//
//                                      );
//                                    }
//                                ),
//                              ),
//                            ],
//                          ),
//                        ),
//                        _dropdownError == null
//                            ? SizedBox.shrink()
//                            : Padding(
//                          padding: const EdgeInsets.only(
//                              left: 20.0, bottom: 20.0),
//                          child: Row(
//                            children: <Widget>[
//                              Text(
//                                _dropdownError ?? "",
//                                style: TextStyle(
//                                    color: Colors.red[700],
//                                    fontSize: 12.0),
//                              ),
//                            ],
//                          ),
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.only(
//                              left: 20.0, right: 20.0, bottom: 10.0, top: 30.0),
//                          child: Column(
//                            children: <Widget>[
//                              Row(
//                                children: <Widget>[
//                                  Icon(
//                                    Icons.credit_card,
//                                    color: Colors.grey[400],
//                                    size: 19.0,
//                                  ),
//                                  SizedBox(
//                                    width: 10.0,
//                                  ),
//                                  Text(
//                                    'Número do Cartão',
//                                    style:
//                                    TextStyle(color: Colors.grey[500]),
//                                  ),
//                                ],
//                              ),
//                              TextFormField(
//                                //maxLength: 13,
//                                inputFormatters: [maskFormatter],
//                                key: _numeroCartaoKey,
//                                controller: TextEditingController(text: extrato,
//                                ),
//                                validator: composeValidators(
//                                    'o número do Cartão', [
//                                  requiredValidator,
//                                  numeroCartaoValidator
//                                ]),
//                                onSaved: (value) =>
//                                _loginData.numeroCartao = value,
//                                decoration: InputDecoration(
//                                    hintText: ' ',
//                                    hintStyle:
//                                    TextStyle(color: Colors.grey[500])),
//                              ),
//
//                            ],
//                          ),
//                        ),
////                            ListView.builder(
////                              itemCount: _cartaoExtrato.length,
////                              itemBuilder: (BuildContext context, int index) {
////                                return Padding(
////                                  padding: const EdgeInsets.only(top: 15.0),
////                                  child: Stack(
////                                    children: <Widget>[
////                                      FlatButton(
////                                        onPressed: () {
////                                          // _sendDataToSecondScreen(context, index);
////                                        },
////                                        child: Container(
////                                          width: double.infinity,
////                                          height: 50.0,
////
////                                          child: ListTile(
////                                            title: Padding(
////                                              padding:
////                                              const EdgeInsets.fromLTRB(0, 0, 0, 15),
////                                              child: Center(
////                                                child: Text(
////                                                  _cartaoExtrato[index]['nome']
////                                                      .toUpperCase(),
////                                                  style: TextStyle(color: Colors.black38),
////                                                  textAlign: TextAlign.center,
////                                                ),
////                                              ),
////                                            ),
////                                          ),
////                                        ),
////                                      ),
////                                    ],
////                                  ),
////                                );
////                              },
////                            ),
//                        SizedBox(height: 50.0),
//                      ],
//                    ),
//                  ),
//                ),
//                Padding(
//                  padding: const EdgeInsets.all(10.0),
//                  child: FlatButton(
//                    onPressed: () {
//                      if (tipoSolicitacaoSel == null) {
//                        _tipoSolicitacaoSelecionada = true;
//                      }
//                      _validateForm();
//                      final form = _formKey.currentState;
//                      if (form.validate()) {
//                        form.save();
//                        print(
//                            'password is: ${_loginData.password}, confirmPassword is: ${_loginData.confirmPassword}, email is: ${_loginData.email}, nome is: ${_loginData.nome}');
//
//                        TipoSolicitacao tipoSolicitacao =
//                        new TipoSolicitacao.vazio();
//                        print(idTipoSolicitacao);
//                        if (idTipoSolicitacao != null) {
//                          tipoSolicitacao.id = idTipoSolicitacao;
//                          tipoSolicitacao.nome = _selectedFieldTipoSolicitacao;
//                        }
//
//                        user.nome = _loginData.nome;
//                        user.cpf = _loginData.cpf;
//                        user.nascimento = _loginData.nascimento;
//
//                        String url = 'http://app.cartaopec.com.br/api/cadastros';
//                        Map<String, dynamic> map = user.toJson();
//                        String body = jsonEncode(map);
//                        print(body);
//
//                        http
//                            .put(url,
//                            headers: {'Content-Type': 'application/json'},
//                            body: body)
//                            .then((http.Response response) {
//                          print("Response status: ${response.statusCode}");
//                          //print("Response body: ${response.contentLength}");
//                          //print(response.headers);
//                          print(response.body);
//                          if (response.statusCode == 200) {
//                            print("PASSOUYALL");
//                            if (mostrarDataSelecionada == true) {
//                              showDialog(
//                                context: context,
//                                builder: (BuildContext context) {
//                                  // return object of type Dialog
//                                  return AlertDialog(
//                                    title: Center(
//                                        child: new Text(
//                                          "Atenção!",
//                                          textAlign: TextAlign.center,
//                                        )),
//                                    content: new Text(
//                                      "O extrato será enviado para o e-mail cadastrado em seu perfil.",
//                                      textAlign: TextAlign.center,
//                                    ),
//                                    actions: <Widget>[
//                                      // usually buttons at the bottom of the dialog
//                                      new FlatButton(
//                                        child: new Text(
//                                          "Ok",
//                                          style: TextStyle(
//                                            fontSize: 18,
//                                          ),
//                                        ),
//                                        onPressed: () {
//                                          Navigator.of(context).pop();
//                                        },
//                                      ),
//                                    ],
//                                  );
//                                },
//                              );
//                              Future.delayed(const Duration(milliseconds: 3000),
//                                      () {
//                                    //setState(() {
//                                    Navigator.push(
//                                      context,
//                                      MaterialPageRoute(
//                                        builder: (context) =>
//                                            Status(user: user, token: token, sol: sol),
//                                      ),
//                                    );
//                                    Navigator.of(context).pushAndRemoveUntil(
//                                        MaterialPageRoute(
//                                            builder: (context) => TelaLogin()),
//                                            (Route<dynamic> route) => false);
//                                    //});
//                                  });
//                            }
//                          }
//                        });
//                      } else {
//                        setState(() => _autovalidate = true);
//                      }
//                      if (form.validate()) {
//                        form.save();
//                      }
//                    },
//                    textColor: Colors.white,
//                    color: Colors.white,
//                    child: Container(
//                      width: double.infinity,
//                      height: 45.0,
//                      decoration: BoxDecoration(
//                        borderRadius: BorderRadius.circular(15.0),
//                        gradient: LinearGradient(
//                          colors: <Color>[
//                            Color(0xFF33691E),
//                            Color(0xFF689F38),
//                            Color(0xFF8BC34A),
//                          ],
//                        ),
//                      ),
//                      child: Center(
//                          child: const Text('SOLICITAR EXTRATO',
//                              style: TextStyle(fontSize: 20))),
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          )),
//    );
//  }
//}
//
////