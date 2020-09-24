import 'dart:convert';

import 'package:ett_app/style/lightColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ett_app/models/forms.dart';
import 'package:ett_app/screens/login.dart';
import 'package:ett_app/style/sizeConfig.dart';
import 'package:ett_app/utils/validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class EsqueceuSenha extends StatefulWidget {
  @override
  EsqueceuSenhaState createState() {
    return EsqueceuSenhaState();
  }
}

class EsqueceuSenhaState extends State<EsqueceuSenha> {
  List<dynamic> _docs = [];

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _emailKey =
      GlobalKey<FormFieldState<String>>();

  LoginFormData _loginData = LoginFormData();
  bool _autovalidate = true;

  final _emailController = TextEditingController();

  void _fetchDocs() {
    http
        .get(
            "https://www.accio.com.br:447/api/v1/usuarios/?access_token=d16e3966-eb87-4337-bfee-bee54b5a4052")
        .then((res) {
      final docs = json.decode(res.body);

      setState(() {
        _docs = docs;
      });
    });
  }

  @override
  initState() {
    super.initState();
    _fetchDocs();
  }

  @override
  dispose() {
    _emailController.dispose();

    super.dispose();
  }

  _submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      print('e-mail is: ${_loginData.email}');
    } else {
      setState(() => _autovalidate = true);
    }
  }

  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          iconTheme: new IconThemeData(color: LightColors.neonYellowDark),
          title: Center(
              child: Text(
            ' ',
            style: TextStyle(color: Colors.black),
          )),
          backgroundColor: Colors.grey[50],
          elevation: 0,
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                child: Row(
                  children: <Widget>[],
                ))
          ],
        ),
        // backgroundColor: LightColors.neonYellowLight,
        body: Container(
            child: SafeArea(
          bottom: false,
          top: false,
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/YellowBus.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                width: SizeConfig.safeBlockVertical * 30,
                                child: Image(
                                  image: AssetImage('images/logo-slim.png'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        //margin: EdgeInsets.fromLTRB(0.0, 0.0, 40.0, 0.0),
                        child: Form(
                          key: _formKey,
                          autovalidate: _autovalidate,
                          child: Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Container(
                              width: double.infinity,
                              height: 350,
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, top: 30.0),
                                      child: Text(
                                          "Digite o seu e-mail cadastrado:",
                                          style: GoogleFonts.raleway(
                                              color: Colors.black87,
                                              fontSize: 19.0,
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 0.7)),
                                    ),
                                    SizedBox(
                                      height: 30.0,
                                    ),
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, right: 20.0, top: 50.0),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.email,
                                            color: Colors.black54,
                                            size: 19.0,
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text('E-mail',
                                              style: GoogleFonts.raleway(
                                                  color: Colors.black54,
                                                  fontSize: 16)),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, right: 20.0),
                                      child: TextFormField(
                                        key: _emailKey,
                                        controller: _emailController,
                                        validator: composeValidators('email', [
                                          requiredValidator,
                                          minLegthValidator,
                                          emailValidator,
                                        ]),
                                        onSaved: (value) =>
                                            _loginData.email = value,
                                        decoration: InputDecoration(
                                            hintText: 'nome@email.com'),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FlatButton(
                          onPressed: () {
                            _submit();

                            bool flag = false;
                            for (int c = 0; c < _docs.length; c++) {
                              print(c);
                              if (_docs[c]['email'] == _emailController.text) {
                                flag = true;
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    // return object of type Dialog
                                    return AlertDialog(
                                      title: Center(
                                          child: new Text(
                                        "Atenção!",
                                        textAlign: TextAlign.center,
                                      )),
                                      content: new Text(
                                        "E-mail enviado com sucesso!",
                                        textAlign: TextAlign.center,
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
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        TelaLogin()));
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            }
                            if (flag == false) {
                              final snackBar = new SnackBar(
                                  content: new Text('Erro na autenticação'));
                              _scaffoldKey.currentState.showSnackBar(snackBar);
                              //print(_passwordController.text.toString());
                            }
                          },
                          textColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Container(
                              width: double.infinity,
                              height: 45.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Colors.grey[600],
                                    Colors.grey[500],
                                    Colors.grey[300],
                                  ],
                                ),
                              ),
                              //padding: const EdgeInsets.fromLTRB(90.0, 15.0, 90.0, 15.0),
                              child: Center(
                                  child: const Text('ENVIAR',
                                      style: TextStyle(fontSize: 20))),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )));
  }
}
