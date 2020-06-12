import 'package:ett_app/domains/solicitacao.dart';
import 'package:ett_app/screens/appBar.dart';
import 'package:flutter/material.dart';
import 'package:ett_app/models/forms.dart';
import 'package:ett_app/style/sizeConfig.dart';
import 'package:ett_app/screens/status.dart';
import 'package:ett_app/utils/validators.dart';
import 'package:ett_app/domains/usuario.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'login.dart';

class EnviarAlteracaoEscala extends StatefulWidget {
  Usuario user;
  Token token;
  Solicitacao sol;

  EnviarAlteracaoEscala(
      {Key key,
      // this.value,
      this.user,
      this.token,
      this.sol})
      : super(key: key);

  @override
  EnviarAlteracaoEscalaState createState() {
    return EnviarAlteracaoEscalaState(user: user, token: token, sol: sol);
  }
}

class EnviarAlteracaoEscalaState extends State<EnviarAlteracaoEscala> {
  Usuario user;
  Token token;
  Solicitacao sol;


  EnviarAlteracaoEscalaState({this.user, this.token,
    this.sol});

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _foraDeServicoKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _veiculoKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _motivoKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _descricaoKey =
      GlobalKey<FormFieldState<String>>();

  LoginFormData _loginData = LoginFormData();
  bool _autovalidate = false;

  final _foraDeServicoController = TextEditingController();
  final _veiculoController = TextEditingController();
  final _motivoController = TextEditingController();
  final _descricaoController = TextEditingController();

  //mask
  var dataController = new MaskedTextController(mask: '00/00/0000');

  @override
  initState() {
    super.initState();
    this.getSWData();
  }

  @override
  dispose() {
    _foraDeServicoController.dispose();
    _veiculoController.dispose();
    _motivoController.dispose();
    _descricaoController.dispose();

    super.dispose();
  }

  _submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
    } else {
      setState(() => _autovalidate = true);
    }
  }

  //Motivo
  String _dropdownError;

  _validateForm() {
    bool _isValid = _formKey.currentState.validate();

    if (_mySelection == null ) {
      setState(() => _dropdownError = "Selecione uma opção");
      _isValid = false;
    }

    if (_isValid) {
      //form is valid
    }
  }

  // Initially is obscure
  bool _obscureText = true;

  // Toggles show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Users _motivoEscolhido;

  String _mySelection;

  final String url = "http://webmyls.com/php/getdata.php";

  List data = List(); //edited line

  Future<String> getSWData() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      data = resBody;
    });

    print(resBody);

    return "Sucesso";
  }

  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarETT(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
//                Padding(
//                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
//                  child: Center(
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      mainAxisSize: MainAxisSize.min,
//                      children: <Widget>[
//                        Container(
//                          width: SizeConfig.safeBlockVertical * 30,
//                          child: Image(
//                            image: AssetImage('images/logo-slim-tsp.png'),
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Container(
                    width: double.infinity,
                    //margin: EdgeInsets.fromLTRB(0.0, 0.0, 40.0, 0.0),
                    child: Form(
                      key: _formKey,
                      autovalidate: _autovalidate,
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Container(
                          width: double.infinity,
                          height: 800,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0.0, 15.0),
                                    blurRadius: 15.0),
                                BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0.0, -10.0),
                                    blurRadius: 10.0),
                              ]),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 10.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, top: 30.0),
                                  child: Text(
                                      "Formulário de Alteração de Escala",
                                      style: TextStyle(
                                          fontSize: 19.0,
                                          color: Colors.grey[700],
                                          fontFamily: "Poppins-Bold",
                                          letterSpacing: .6)),
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        'Fora de serviço: *',
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 17.0),
                                      ),
//                                    Spacer(),
//                                    new FlatButton(
//                                        onPressed: _toggle,
//                                        child: new Icon(
//                                            _obscureText
//                                                ? Icons.remove_red_eye
//                                                : Icons.lock,
//                                            color: Colors.grey))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0),
                                  child: TextFormField(
                                    key: _foraDeServicoKey,
                                    controller: dataController,
                                    validator: composeValidators('a data',
                                        [requiredValidator, minLegthValidator]),
                                    onSaved: (value) =>
                                        _loginData.foraDeServico = value,
                                    decoration: InputDecoration(
                                        //border: OutlineInputBorder(
                                        // borderRadius: BorderRadius.circular(5.0)),
                                        //labelText: 'E-mail',
                                        //border: InputBorder.none,
                                        hintText: ''),
                                    //obscureText: _obscureText,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        'Veículo: *',
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 17.0),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0, top: 10.0),
                                  child: TextFormField(
                                    key: _veiculoKey,
                                    controller: _veiculoController,
                                    validator: composeValidators('a placa',
                                        [requiredValidator, minLegthValidator]),
                                    onSaved: (value) =>
                                        _loginData.veiculo = value,
                                    decoration: InputDecoration(
                                        //border: OutlineInputBorder(
                                        // borderRadius: BorderRadius.circular(5.0)),
                                        //labelText: 'E-mail',
                                        //border: InputBorder.none,
                                        hintText: ''),
//                                    obscureText: _obscureText,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        'Motivo: *',
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 17.0),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0),
                                  child: DropdownButton(
                                    items: data.map((item) {
                                      return new DropdownMenuItem(
                                        child: new Text(item['item_name']),
                                        value: item['id'].toString(),
                                      );
                                    }).toList(),
                                    onChanged: (newVal) {
                                      setState(() {
                                        _mySelection = newVal;
                                        _dropdownError = null;
                                      });
                                    },
                                    value: _mySelection,
                                    isExpanded: true,
                                    hint: Text('Selecione o motivo'),
                                  ),
                                ),
                                _dropdownError == null
                                    ? SizedBox.shrink()
                                    : Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    _dropdownError ?? "",
                                    style: TextStyle(color: Colors.red[800], fontSize: 12),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        'Descrição:',
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 17.0),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0, top: 10.0),
                                  child: TextFormField(
                                    key: _descricaoKey,
                                    controller: _descricaoController,
                                    validator:
                                        composeValidators('a descrição', []),
                                    onSaved: (value) =>
                                        _loginData.descricao = value,
                                    decoration: InputDecoration(
                                        //border: OutlineInputBorder(
                                        // borderRadius: BorderRadius.circular(5.0)),
                                        //labelText: 'E-mail',
                                        //border: InputBorder.none,
                                        hintText: ''),
//                                    obscureText: _obscureText,
                                  ),
                                ),
                                SizedBox(height: 50.0),
                                FlatButton(child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: FlatButton(
                                    onPressed: () {
                                      _validateForm();
                                      if(_formKey.currentState.validate()
                                      && _mySelection != null
                                      ) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            // return object of type Dialog
                                            return AlertDialog(
                                              title: Center(
                                                  child: new Icon(
                                                    Icons.check_circle, size: 50.0, color: Colors.green,)),
                                              content: Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: new Text(
                                                      'Formulário registrado com sucesso!', style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.grey[600],
                                                        fontFamily: "Poppins-Bold",
                                                        letterSpacing: .6),
                                                    ),
                                                  ),

                                                ],
                                              ),

                                              actions: <Widget>[
                                                // usually buttons at the bottom of the dialog
                                                new FlatButton(
                                                  child: new Text(
                                                    "Ok",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                        Future.delayed(const Duration(milliseconds: 3000), () {
                                          //setState(() {

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) =>
                                                Status(
                                                    sol: sol,
                                                    user: user,
                                                    token: token
                                                  //textSucesso: textSucesso,
                                                  //alertSucessoVisible: alertSucessoVisible,

                                                ),
                                            ),
                                          );
                                          //});
                                        });
                                      }else {
                                        final semCadastro =
                                        new SnackBar(content: new Text('Preencha todos os campos para prosseguir!'));
                                        _scaffoldKey.currentState.showSnackBar(semCadastro);
                                      }


                                    },
                                    textColor: Colors.white,
                                    color: Colors.white,
                                    child: Container(
                                      width: double.infinity,
                                      height: 45.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.0),
                                        gradient: LinearGradient(
                                          colors: <Color>[
                                            Colors.yellow[800],
                                            Colors.yellow[700],
                                            Colors.yellow[600],
                                          ],
                                        ),
                                      ),
                                      child: Center(
                                        child: const Text('ENVIAR',
                                            style: TextStyle(fontSize: 20)),
                                      ),
                                    ),
                                  ),
                                ),),
                                SizedBox(height: 10.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Users {
  int id;
  String name;

  Users({
    this.id,
    this.name,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'],
      name: json['name'],
    );
  }
}
