//import 'package:flutter/material.dart';
//import 'package:ett_app/models/forms.dart';
//import 'package:ett_app/style/sizeConfig.dart';
//import 'package:ett_app/screens/status.dart';
//import 'package:ett_app/utils/validators.dart';
//import 'package:ett_app/domains/Usuario.dart';
//import 'package:flutter/services.dart';
//
//import 'dart:convert';
//import 'dart:async';
//import 'package:http/http.dart' as http;
//
//import 'appBar.dart';
//import '../style/lightColors.dart';
//
//class ComunicadoInterno extends StatefulWidget {
//
//  Usuario user;
//
//  ComunicadoInterno(
//      {Key key,
//        // this.value,
//        this.user})
//      : super(key: key);
//
//  @override
//  ComunicadoInternoState createState() {
//    return ComunicadoInternoState(user: user);
//  }
//}
//
//class ComunicadoInternoState extends State<ComunicadoInterno> {
//  Usuario user;
//
//  ComunicadoInternoState({this.user});
//
//  final _scaffoldKey = GlobalKey<ScaffoldState>();
//
//  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//  final GlobalKey<FormFieldState<String>> _dataKey =
//  GlobalKey<FormFieldState<String>>();
//  final GlobalKey<FormFieldState<String>> _horaKey =
//  GlobalKey<FormFieldState<String>>();
//  final GlobalKey<FormFieldState<String>> _veiculoKey =
//  GlobalKey<FormFieldState<String>>();
//  final GlobalKey<FormFieldState<String>> _chapaKey =
//  GlobalKey<FormFieldState<String>>();
//  final GlobalKey<FormFieldState<String>> _nomeKey =
//  GlobalKey<FormFieldState<String>>();
//  final GlobalKey<FormFieldState<String>> _localKey =
//  GlobalKey<FormFieldState<String>>();
//  final GlobalKey<FormFieldState<String>> _mensagemKey =
//  GlobalKey<FormFieldState<String>>();
//
//
//  LoginFormData _loginData = LoginFormData();
//  bool _autovalidate = true;
//
//  final _dataController = TextEditingController();
//  final _horaController = TextEditingController();
//  final _veiculoController = TextEditingController();
//  final _chapaController = TextEditingController();
//  final _nomeController = TextEditingController();
//  final _localController = TextEditingController();
//  final _mensagemController = TextEditingController();
//
//  TextEditingController _textFieldController = TextEditingController();
//
//  @override
//  initState() {
//    super.initState();
//    this.getSWData();
//  }
//
//  @override
//  dispose() {
//    _dataController.dispose();
//    _horaController.dispose();
//    _veiculoController.dispose();
//    _chapaController.dispose();
//    _nomeController.dispose();
//    _localController.dispose();
//    _mensagemController.dispose();
//
//    super.dispose();
//  }
//
//  _submit() {
//    final form = _formKey.currentState;
//    if (form.validate()) {
//      form.save();
//    } else {
//      setState(() => _autovalidate = true);
//    }
//  }
//
//  // Initially is obscure
//  bool _obscureText = true;
//
//  //Checkbox
//  bool _isCheckedDir = false;
//  bool _isCheckedOf = false;
//  bool _isCheckedOp = false;
//  bool _isCheckedPl = false;
//  bool _isCheckedTI = false;
//
//  void onChangedDIR(bool value) {
//    setState(() {
//      _isCheckedDir = value;
//    });
//  }
//
//  void onChangedOF(bool value) {
//    setState(() {
//      _isCheckedOf = value;
//    });
//  }
//
//  void onChangedOP(bool value) {
//    setState(() {
//      _isCheckedOp = value;
//    });
//  }
//
//  void onChangedPL(bool value) {
//    setState(() {
//      _isCheckedPl = value;
//    });
//  }
//
//  void onChangedTI(bool value) {
//    setState(() {
//      _isCheckedTI = value;
//    });
//  }
//
//  // Toggles show status
//  void _toggle() {
//    setState(() {
//      _obscureText = !_obscureText;
//    });
//  }
//
//  Users _motivoEscolhido;
//
//  String _mySelection;
//  String _mySelectionSentido;
//
//  final String url = "http://webmyls.com/php/getdata.php";
//
//  List data = List(); //edited line
//
//  Future<String> getSWData() async {
//    var res = await http
//        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
//    var resBody = json.decode(res.body);
//
//    setState(() {
//      data = resBody;
//    });
//
//    print(resBody);
//
//    return "Sucesso";
//  }
//
//  int _charCount = 700;
//
//  _onChanged(String value) {
//    setState(() {
//      _charCount = 700 - value.length;
//    });
//  }
//
//
//
//  @override
//  Widget build(BuildContext context) {
//    SizeConfig().init(context);
//    return Scaffold(
//      key: _scaffoldKey,
//      appBar: AppBar(
//        backgroundColor: LightColors.neonETT,
//        elevation: 0,
//      ),
//      backgroundColor: Colors.white,
//      body: SafeArea(
//        child: ListView(
//          shrinkWrap: true,
//          children: <Widget>[
//
//
//            Column(
//
//              mainAxisAlignment: MainAxisAlignment.spaceAround,
//              children: <Widget>[
////                Padding(
////                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
////                  child: Center(
////                    child: Row(
////                      mainAxisAlignment: MainAxisAlignment.center,
////                      mainAxisSize: MainAxisSize.min,
////                      children: <Widget>[
////                        Container(
////                          width: SizeConfig.safeBlockVertical * 30,
////                          child: Image(
////                            image: AssetImage('images/ETT.png'),
////                          ),
////                        ),
////                      ],
////                    ),
////                  ),
////                ),
//                Padding(
//                  padding: const EdgeInsets.only(top: 10.0, bottom: 70.0),
//                  child: Container(
//                    width: double.infinity,
//                    //margin: EdgeInsets.fromLTRB(0.0, 0.0, 40.0, 0.0),
//                    child: Form(
//                      key: _formKey,
//                      autovalidate: _autovalidate,
//                      child:
//                      Padding(
//                        padding: const EdgeInsets.all(25.0),
//                        child: Container(
//                          width: double.infinity,
//                          height: 1550,
//                          decoration: BoxDecoration(
//                              color: Colors.white,
//                              borderRadius: BorderRadius.circular(8.0),
//                              boxShadow: [
//                                BoxShadow(
//                                    color: Colors.black12,
//                                    offset: Offset(0.0, 15.0),
//                                    blurRadius: 15.0),
//                                BoxShadow(
//                                    color: Colors.black12,
//                                    offset: Offset(0.0, -10.0),
//                                    blurRadius: 10.0),
//                              ]),
//                          child: Padding(
//                            padding: EdgeInsets.only(
//                                left: 16.0, right: 16.0, top: 16.0),
//                            child: Column(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              children: <Widget>[
//                                SizedBox(
//                                  height: 10.0,
//                                ),
//                                Padding(
//                                  padding: const EdgeInsets.only(left: 20.0, top: 5.0),
//                                  child: Text("F-010 Comunicado Interno",
//                                      style: TextStyle(
//                                          fontSize: 19.0,
//                                          color: Colors.grey[700],
//                                          fontFamily: "Poppins-Bold",
//                                          letterSpacing: .6)),
//                                ),
//                                SizedBox(
//                                  height: 30.0,
//                                ),
//                                SizedBox(height: 10),
//                                Padding(
//                                  padding: const EdgeInsets.only(
//                                      left: 20.0, right: 20.0),
//                                  child: Row(
//                                    children: <Widget>[
//                                      Text(
//                                        'Data: *',
//                                        style: TextStyle(
//                                            color: Colors.grey[600],
//                                            fontSize: 17.0),
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                                Padding(
//                                  padding: const EdgeInsets.only(
//                                      left: 20.0, right: 20.0),
//                                  child: TextFormField(
//                                    key: _dataKey,
//                                    controller: _dataController,
//                                    validator: composeValidators('a data', [
//                                      requiredValidator,
//                                      minLegthValidator
//                                    ]
//                                    ),
//                                    onSaved: (value) =>
//                                    _loginData.foraDeServico = value,
//                                    decoration: InputDecoration(
//                                        hintText: ''),
//                                  ),
//                                ),
//                                SizedBox(
//                                  height: 20.0,
//                                ),
//                                Padding(
//                                  padding: const EdgeInsets.only(
//                                      left: 20.0, right: 20.0),
//                                  child: Row(
//                                    children: <Widget>[
//                                      Text(
//                                        'Hora: *',
//                                        style: TextStyle(
//                                            color: Colors.grey[600],
//                                            fontSize: 17.0),
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                                Padding(
//                                  padding: const EdgeInsets.only(
//                                      left: 20.0, right: 20.0),
//                                  child: TextFormField(
//                                    key: _horaKey,
//                                    controller: _horaController,
//                                    validator: composeValidators('a hora', [
//                                      requiredValidator,
//                                      minLegthValidator]),
//                                    onSaved: (value) =>
//                                    _loginData.hora = value,
//                                    decoration: InputDecoration(
//                                        hintText: ''),
//                                  ),
//                                ),
//                                SizedBox(
//                                  height: 20.0,
//                                ),
//                                Padding(
//                                  padding: const EdgeInsets.only(
//                                      left: 20.0, right: 20.0),
//                                  child: Row(
//                                    children: <Widget>[
//
//                                      Text(
//                                        'Chapa do funcionário associado:',
//                                        style: TextStyle(
//                                            color: Colors.grey[600],
//                                            fontSize: 17.0),
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                                Padding(
//                                  padding: const EdgeInsets.only(
//                                      left: 20.0, right: 20.0, top: 10.0),
//                                  child: TextFormField(
//                                    key: _chapaKey,
//                                    controller: _chapaController,
//                                    validator: composeValidators('a chapa', [
//                                      minLegthValidator
//                                    ]),
//                                    onSaved: (value) =>
//                                    _loginData.chapa = value,
//                                    decoration: InputDecoration(
//                                        hintText: ''),
//                                  ),
//                                ),
//                                SizedBox(
//                                  height: 20.0,
//                                ),
//                                Padding(
//                                  padding: const EdgeInsets.only(
//                                      left: 20.0, right: 20.0),
//                                  child: Row(
//                                    children: <Widget>[
//
//                                      Text(
//                                        'Nome:',
//                                        style: TextStyle(
//                                            color: Colors.grey[600],
//                                            fontSize: 17.0),
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                                Padding(
//                                  padding: const EdgeInsets.only(
//                                      left: 20.0, right: 20.0, top: 10.0),
//                                  child: TextFormField(
//                                    key: _nomeKey,
//                                    controller: _nomeController,
//                                    validator: composeValidators('o nome', [
//                                      minLegthValidator
//                                    ]),
//                                    onSaved: (value) =>
//                                    _loginData.veiculo = value,
//                                    decoration: InputDecoration(
//                                        hintText: ''),
//                                  ),
//                                ),
//                                SizedBox(
//                                  height: 20.0,
//                                ),
//                                Padding(
//                                  padding: const EdgeInsets.only(
//                                      left: 20.0, right: 20.0),
//                                  child: Row(
//                                    children: <Widget>[
//
//                                      Text(
//                                        'Veículo:',
//                                        style: TextStyle(
//                                            color: Colors.grey[600],
//                                            fontSize: 17.0),
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                                Padding(
//                                  padding: const EdgeInsets.only(
//                                      left: 20.0, right: 20.0, top: 10.0),
//                                  child: TextFormField(
//                                    key: _veiculoKey,
//                                    controller: _veiculoController,
//                                    validator: composeValidators('o veículo', [
//                                      minLegthValidator
//                                    ]),
//                                    onSaved: (value) =>
//                                    _loginData.veiculo = value,
//                                    decoration: InputDecoration(
//                                        hintText: ''),
//                                  ),
//                                ),
//                                SizedBox(
//                                  height: 20.0,
//                                ),
//                                Padding(
//                                  padding: const EdgeInsets.only(
//                                      left: 20.0, right: 20.0),
//                                  child: Row(
//                                    children: <Widget>[
//
//                                      Text(
//                                        'Local da ocorrência:',
//                                        style: TextStyle(
//                                            color: Colors.grey[600],
//                                            fontSize: 17.0),
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                                Padding(
//                                  padding: const EdgeInsets.only(
//                                      left: 20.0, right: 20.0, top: 10.0),
//                                  child: TextFormField(
//                                    key: _localKey,
//                                    controller: _localController,
//                                    validator: composeValidators('o local da ocorrência', [
//                                      minLegthValidator
//                                    ]),
//                                    onSaved: (value) =>
//                                    _loginData.local = value,
//                                    decoration: InputDecoration(
//                                        hintText: ''),
//                                  ),
//                                ),
//                                SizedBox(
//                                  height: 20.0,
//                                ),
//                                Padding(
//                                  padding: const EdgeInsets.only(
//                                      left: 20.0, right: 20.0),
//                                  child: Row(
//                                    children: <Widget>[
//
//                                      Text(
//                                        'Linha:',
//                                        style: TextStyle(
//                                            color: Colors.grey[600],
//                                            fontSize: 17.0),
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                                SizedBox(
//                                  height: 20.0,
//                                ),
//                                Padding(
//                                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//                                  child: DropdownButton(
//                                    items: data.map((item) {
//                                      return new DropdownMenuItem(
//                                        child: new Text(item['item_name']),
//                                        value: item['id'].toString(),
//                                      );
//                                    }).toList(),
//                                    onChanged: (newVal) {
//                                      setState(() {
//                                        _mySelection = newVal;
//                                      });
//                                    },
//                                    value: _mySelection,
//                                    isExpanded: true,
//                                    hint: Text('Selecione a linha'),
//                                  ),
//                                ),
//
//                                SizedBox(
//                                  height: 20.0,
//                                ),
//
//                                Padding(
//                                  padding: const EdgeInsets.only(
//                                      left: 20.0, right: 20.0),
//                                  child: Row(
//                                    children: <Widget>[
//
//                                      Text(
//                                        'Sentido:',
//                                        style: TextStyle(
//                                            color: Colors.grey[600],
//                                            fontSize: 17.0),
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                                SizedBox(
//                                  height: 20.0,
//                                ),
//                                Padding(
//                                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//                                  child: DropdownButton(
//                                    items: data.map((item) {
//                                      return new DropdownMenuItem(
//                                        child: new Text(item['item_name']),
//                                        value: item['id'].toString(),
//                                      );
//                                    }).toList(),
//                                    onChanged: (valSentido) {
//                                      setState(() {
//                                        _mySelectionSentido = valSentido;
//                                      });
//                                    },
//                                    value: _mySelectionSentido,
//                                    isExpanded: true,
//                                    hint: Text('Selecione o sentido'),
//                                  ),
//                                ),
//
//                                SizedBox(
//                                  height: 20.0,
//                                ),
//
//                                Padding(
//                                  padding: const EdgeInsets.only(
//                                      left: 20.0, right: 20.0),
//                                  child: Row(
//                                    children: <Widget>[
//
//                                      Text(
//                                        'Mensagem:',
//                                        style: TextStyle(
//                                            color: Colors.grey[600],
//                                            fontSize: 17.0),
//                                      ),
//                                    ],
//                                  ),
//                                ),
//
//                                Column(
//                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                  children: <Widget>[
//                                    Padding(
//                                      padding: EdgeInsets.symmetric(horizontal: 25.0),
//                                      child: TextField(
//                                        maxLines: 5,
//                                        controller: _textFieldController,
//                                        onChanged: _onChanged,
//                                          inputFormatters: [
//                                            LengthLimitingTextInputFormatter(700),
//                                          ],
//                                      ),
//                                    ),
//                                    SizedBox(height: 20.0),
//                                    Padding(
//                                      padding: const EdgeInsets.only(left: 20.0),
//                                      child: Text( _charCount.toString() + " caracteres restantes",
//                                          style: TextStyle(color: Colors.grey[600],
//                                              fontSize: 12.0)),
//                                    ),
//                                  ],
//                                ),
//                                SizedBox(
//                                  height: 30.0,
//                                ),
//
//                                Padding(
//                                  padding: const EdgeInsets.only(
//                                      left: 20.0, right: 20.0),
//                                  child: Row(
//                                    children: <Widget>[
//
//                                      Text(
//                                        'Quem pode ver esse relatório:',
//                                        style: TextStyle(
//                                            color: Colors.grey[600],
//                                            fontSize: 17.0),
//                                      ),
//                                    ],
//                                  ),
//                                ),
//
//                                  Padding(
//                                    padding: const EdgeInsets.only(top: 10.0),
//                                    child: Column(
//                                      children: <Widget>[
//                                        new CheckboxListTile(
//                                            title: new Text(
//                                              'Diretoria',
//                                              style: TextStyle(
//                                                  color: Colors.grey[600],
//                                                  fontSize: 13.0,
//                                                  fontWeight: FontWeight.w600),
//                                            ),
//                                            value: _isCheckedDir,
//                                            activeColor: Colors.yellow[700],
//                                            onChanged: (bool value) {
//                                              onChangedDIR(value);
//                                            }),
//
//                                        new CheckboxListTile(
//                                            title: new Text(
//                                              'Oficina',
//                                              style: TextStyle(
//                                                  color: Colors.grey[600],
//                                                  fontSize: 13.0,
//                                                  fontWeight: FontWeight.w600),
//                                            ),
//                                            value: _isCheckedOf,
//                                            activeColor: Colors.yellow[700],
//                                            onChanged: (bool value) {
//                                              onChangedOF(value);
//                                            }
//                                            ),
//
//                                        new CheckboxListTile(
//                                            title: new Text(
//                                              'Operacional',
//                                              style: TextStyle(
//                                                  color: Colors.grey[600],
//                                                  fontSize: 13.0,
//                                                  fontWeight: FontWeight.w600),
//                                            ),
//                                            value: _isCheckedOp,
//                                            activeColor: Colors.yellow[700],
//                                            onChanged: (bool value) {
//                                              onChangedOP(value);
//                                            }
//                                        ),
//
//                                        new CheckboxListTile(
//                                            title: new Text(
//                                              'Plantão',
//                                              style: TextStyle(
//                                                  color: Colors.grey[600],
//                                                  fontSize: 13.0,
//                                                  fontWeight: FontWeight.w600),
//                                            ),
//                                            value: _isCheckedPl,
//                                            activeColor: Colors.yellow[700],
//                                            onChanged: (bool value) {
//                                              onChangedPL(value);
//                                            }
//                                        ),
//
//                                        new CheckboxListTile(
//                                            title: new Text(
//                                              'TI',
//                                              style: TextStyle(
//                                                  color: Colors.grey[600],
//                                                  fontSize: 13.0,
//                                                  fontWeight: FontWeight.w600),
//                                            ),
//                                            value: _isCheckedTI,
//                                            activeColor: Colors.yellow[700],
//                                            onChanged: (bool value) {
//                                              onChangedTI(value);
//                                            }
//                                        ),
//                                      ],
//                                    ),
//                                  ),
//
//                                SizedBox(height: 40.0),
//
//                                FlatButton(child: Padding(
//                                  padding: const EdgeInsets.only(bottom: 20.0),
//                                  child: FlatButton(
//                                    onPressed: () {
//                                      // Validate returns true if the form is valid, or false
//                                      // otherwise.
////                          if (_formKey.currentState.validate()) {
////                            _makePostRequest(_emailController.text,
////                                _passwordController.text);
////
////                            // If the form is valid, display a Snackbar.
//////                      Scaffold.of(context).showSnackBar(
//////                          SnackBar(content: Text('Processing Data')));
//////                      bool flag = false;
//////                      for (int c = 0; c < _docs.length; c++) {
//////                        print(c);
//////                        if (_docs[c]['email'] == _emailController.text) {
//////                          flag = true;
//////                          if (_docs[c]['senha'] == _passwordController.text) {
//////                            Navigator.push(
//////                              context,
//////                              MaterialPageRoute(builder: (context) => Status()),
//////                            );
//////                            Navigator.of(context).pushAndRemoveUntil(
//////                                MaterialPageRoute(
//////                                    builder: (context) => Status()),
//////                                (Route<dynamic> route) => false);
//////                          } else {
//////                            final snackBar = new SnackBar(
//////                                content:
//////                                    new Text('E-mail ou senha incorretos'));
//////                            _scaffoldKey.currentState.showSnackBar(snackBar);
//////                            //print(_passwordController.text.toString());
//////                          }
//////                        }
//////                      }
//////                      if (flag == false) {
//////                        final semCadastro = new SnackBar(
//////                            content: new Text('Usuário não cadastrado!'));
//////                        _scaffoldKey.currentState.showSnackBar(semCadastro);
//////                      }
////
////                            print(_emailController.text.toString());
////                            print(_passwordController.text.toString());
////                            //}
////                            // _submit();
////                          }
//                                    },
//                                    textColor: Colors.white,
//                                    color: Colors.white,
//                                    child: Container(
//                                      width: double.infinity,
//                                      height: 45.0,
//                                      decoration: BoxDecoration(
//                                        borderRadius: BorderRadius.circular(15.0),
//                                        gradient: LinearGradient(
//                                          colors: <Color>[
//                                            Colors.yellow[800],
//                                            Colors.yellow[700],
//                                            Colors.yellow[600],
//                                          ],
//                                        ),
//                                      ),
//                                      child: Center(
//                                        child: const Text('ENVIAR',
//                                            style: TextStyle(fontSize: 20)),
//                                      ),
//                                    ),
//                                  ),
//                                ),),
//                                SizedBox(height: 10.0),
//                              ],
//                            ),
//                          ),
//                        ),
//                      ),
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          ],
//        ),
//      ),
////      floatingActionButton: Padding(
////        padding: const EdgeInsets.only(left: 30.0, bottom: 30.0),
////        child: FlatButton(
////          onPressed: () {
////            // Validate returns true if the form is valid, or false
////            // otherwise.
//////                          if (_formKey.currentState.validate()) {
//////                            _makePostRequest(_emailController.text,
//////                                _passwordController.text);
//////
//////                            // If the form is valid, display a Snackbar.
////////                      Scaffold.of(context).showSnackBar(
////////                          SnackBar(content: Text('Processing Data')));
////////                      bool flag = false;
////////                      for (int c = 0; c < _docs.length; c++) {
////////                        print(c);
////////                        if (_docs[c]['email'] == _emailController.text) {
////////                          flag = true;
////////                          if (_docs[c]['senha'] == _passwordController.text) {
////////                            Navigator.push(
////////                              context,
////////                              MaterialPageRoute(builder: (context) => Status()),
////////                            );
////////                            Navigator.of(context).pushAndRemoveUntil(
////////                                MaterialPageRoute(
////////                                    builder: (context) => Status()),
////////                                (Route<dynamic> route) => false);
////////                          } else {
////////                            final snackBar = new SnackBar(
////////                                content:
////////                                    new Text('E-mail ou senha incorretos'));
////////                            _scaffoldKey.currentState.showSnackBar(snackBar);
////////                            //print(_passwordController.text.toString());
////////                          }
////////                        }
////////                      }
////////                      if (flag == false) {
////////                        final semCadastro = new SnackBar(
////////                            content: new Text('Usuário não cadastrado!'));
////////                        _scaffoldKey.currentState.showSnackBar(semCadastro);
////////                      }
//////
//////                            print(_emailController.text.toString());
//////                            print(_passwordController.text.toString());
//////                            //}
//////                            // _submit();
//////                          }
////          },
////          textColor: Colors.white,
////          color: Colors.white,
////          child: Container(
////            width: double.infinity,
////            height: 45.0,
////            decoration: BoxDecoration(
////              borderRadius: BorderRadius.circular(15.0),
////              gradient: LinearGradient(
////                colors: <Color>[
////                  Colors.yellow[800],
////                  Colors.yellow[700],
////                  Colors.yellow[600],
////                ],
////              ),
////            ),
////            child: Center(
////              child: const Text('ENVIAR',
////                  style: TextStyle(fontSize: 20)),
////            ),
////          ),
////        ),
////      ),
//    );
//  }
//}
//
//
//class Users {
//  int id;
//  String name;
//
//  Users({
//    this.id,
//    this.name,
//  });
//
//  factory Users.fromJson(Map<String, dynamic> json) {
//    return Users(
//      id: json['id'],
//      name: json['name'],
//    );
//  }
//}
//
//
//
//
//
