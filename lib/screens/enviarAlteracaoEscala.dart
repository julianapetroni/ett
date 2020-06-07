import 'package:ett_app/screens/appBar.dart';
import 'package:flutter/material.dart';
import 'package:ett_app/models/forms.dart';
import 'package:ett_app/style/sizeConfig.dart';
import 'package:ett_app/screens/status.dart';
import 'package:ett_app/utils/validators.dart';
import 'package:ett_app/domains/Usuario.dart';

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class EnviarAlteracaoEscala extends StatefulWidget {
  Usuario user;

  EnviarAlteracaoEscala(
      {Key key,
      // this.value,
      this.user})
      : super(key: key);

  @override
  EnviarAlteracaoEscalaState createState() {
    return EnviarAlteracaoEscalaState(user: user);
  }
}

class EnviarAlteracaoEscalaState extends State<EnviarAlteracaoEscala> {
  Usuario user;

  EnviarAlteracaoEscalaState({this.user});

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
//                            image: AssetImage('images/ETT.png'),
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
                          height: 670,
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
                                    controller: _foraDeServicoController,
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
                                      });
                                    },
                                    value: _mySelection,
                                    isExpanded: true,
                                    hint: Text('Selecione o motivo'),
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
                                FlatButton(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 30.0),
                                    child: FlatButton(
                                      onPressed: () {
                                        // Validate returns true if the form is valid, or false
                                        // otherwise.
//                          if (_formKey.currentState.validate()) {
//                            _makePostRequest(_emailController.text,
//                                _passwordController.text);
//
//                            // If the form is valid, display a Snackbar.
////                      Scaffold.of(context).showSnackBar(
////                          SnackBar(content: Text('Processing Data')));
////                      bool flag = false;
////                      for (int c = 0; c < _docs.length; c++) {
////                        print(c);
////                        if (_docs[c]['email'] == _emailController.text) {
////                          flag = true;
////                          if (_docs[c]['senha'] == _passwordController.text) {
////                            Navigator.push(
////                              context,
////                              MaterialPageRoute(builder: (context) => Status()),
////                            );
////                            Navigator.of(context).pushAndRemoveUntil(
////                                MaterialPageRoute(
////                                    builder: (context) => Status()),
////                                (Route<dynamic> route) => false);
////                          } else {
////                            final snackBar = new SnackBar(
////                                content:
////                                    new Text('E-mail ou senha incorretos'));
////                            _scaffoldKey.currentState.showSnackBar(snackBar);
////                            //print(_passwordController.text.toString());
////                          }
////                        }
////                      }
////                      if (flag == false) {
////                        final semCadastro = new SnackBar(
////                            content: new Text('Usuário não cadastrado!'));
////                        _scaffoldKey.currentState.showSnackBar(semCadastro);
////                      }
//
//                            print(_emailController.text.toString());
//                            print(_passwordController.text.toString());
//                            //}
//                            // _submit();
//                          }
                                      },
                                      textColor: Colors.white,
                                      color: Colors.white,
                                      child: Container(
                                        width: double.infinity,
                                        height: 45.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
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
                                  ),
                                ),
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
//      floatingActionButton: Padding(
//        padding: const EdgeInsets.only(left: 30.0, bottom: 30.0),
//        child: FlatButton(
//          onPressed: () {
//            // Validate returns true if the form is valid, or false
//            // otherwise.
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
//          },
//          textColor: Colors.white,
//          color: Colors.white,
//          child: Container(
//            width: double.infinity,
//            height: 45.0,
//            decoration: BoxDecoration(
//              borderRadius: BorderRadius.circular(15.0),
//              gradient: LinearGradient(
//                colors: <Color>[
//                  Colors.yellow[800],
//                  Colors.yellow[700],
//                  Colors.yellow[600],
//                ],
//              ),
//            ),
//            child: Center(
//              child: const Text('ENVIAR',
//                  style: TextStyle(fontSize: 20)),
//            ),
//          ),
//        ),
//      ),
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
