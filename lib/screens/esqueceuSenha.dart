import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ett_app/models/forms.dart';
import 'package:ett_app/screens/login.dart';
import 'package:ett_app/style/sizeConfig.dart';
import 'package:ett_app/utils/validators.dart';
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
  bool _autovalidate = false;

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
      print('e-mail is: ${_loginData.email}'
          );
    } else {
      setState(() => _autovalidate = true);
    }
  }





  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.grey[600]),
        title: Center(
            child: Text(
              ' ',
              style: TextStyle(color: Colors.grey[400]),
            )),
        backgroundColor: Colors.grey[100],
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
              child: Row(
                children: <Widget>[],
              ))
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[


            Column(

              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          width: SizeConfig.safeBlockVertical * 30,
                          child: Image(
                            image: AssetImage('images/PECLogo.png'),
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
                    child:
                    Padding(
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
                                padding: const EdgeInsets.only(left: 20.0, top: 30.0),
                                child: Text("Digite o seu e-mail cadastrado:",
                                    style: TextStyle(
                                        fontSize: 22.0,
                                        color: Colors.yellow[800],
                                        fontFamily: "Poppins-Bold",
                                        letterSpacing: .6)),
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
                                      color: Colors.grey[400],
                                      size: 19.0,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      'E-mail',
                                      style: TextStyle(
                                          color: Colors.grey[500]),
                                    ),


                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20.0),
                                child: TextFormField(
                                  key: _emailKey,
                                  controller: _emailController,
                                  validator:
                                  composeValidators('email', [
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
                                          builder: (context) => TelaLogin()));

                                    },
                                  ),
                                ],
                              );
                            },
                          );



                        }

                      }
                      if(flag == false){
                        final snackBar = new SnackBar(
                            content:
                            new Text('Erro na autenticação'));
                        _scaffoldKey.currentState.showSnackBar(snackBar);
                        //print(_passwordController.text.toString());
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
                      //padding: const EdgeInsets.fromLTRB(90.0, 15.0, 90.0, 15.0),
                      child: Center(
                          child:
                          const Text('ENVIAR', style: TextStyle(fontSize: 20))),
                    ),
                  ),
                ) ,
              ],
            ),


          ],
        ),
      ),
    );
  }
}
