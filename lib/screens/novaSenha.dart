import 'package:ett_app/domains/solicitacao.dart';
import 'package:ett_app/screens/dasboardScreen.dart';
import 'package:ett_app/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:ett_app/models/forms.dart';
import 'package:ett_app/style/sizeConfig.dart';
import 'package:ett_app/screens/status.dart';
import 'package:ett_app/utils/validators.dart';

import 'package:ett_app/domains/usuario.dart';

class NovaSenha extends StatefulWidget {

  Usuario user;
  Token token;
  Solicitacao sol;

  NovaSenha(
      {Key key,
        // this.value,
        this.user,
      this.token,
      this.sol})
      : super(key: key);

  @override
  NovaSenhaState createState() {
    return NovaSenhaState(user: user, token: token, sol: sol);
  }
}

class NovaSenhaState extends State<NovaSenha> {
  Usuario user;
  Token token;
  Solicitacao sol;

  NovaSenhaState({this.user,
    this.token,
    this.sol});

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _confirmPasswordKey =
      GlobalKey<FormFieldState<String>>();

  LoginFormData _loginData = LoginFormData();
  bool _autovalidate = true;

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  initState() {
    super.initState();
  }

  @override
  dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  _submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      print('password is: ${_loginData.password}'
          ' confirmPassword is: ${_loginData.confirmPassword}');
    } else {
      setState(() => _autovalidate = true);
    }
  }

  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
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
          style: TextStyle(color: Colors.black),
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
                            children: <Widget>[
                              SizedBox(
                                height: 10.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text("Digite a sua nova senha:",
                                    style: TextStyle(
                                        fontSize: 22.0,
                                        color: Colors.green,
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
                                    Icon(
                                      Icons.lock_open,
                                      color: Colors.black87,
                                      size: 19.0,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      'Senha',
                                      style: TextStyle(
                                          color: Colors.grey[500]),
                                    ),
                                    Spacer(),
                                    new FlatButton(
                                        onPressed: _toggle,
                                        child: new Icon(
                                            _obscureText
                                                ? Icons.remove_red_eye
                                                : Icons.lock,
                                            color: Colors.grey))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20.0),
                                child: TextFormField(
                                  key: _passwordKey,
                                  controller: _passwordController,
                                  validator: composeValidators('a senha', [
                                    requiredValidator,
                                    minLegthValidator
                                  ]),
                                  onChanged: (value) =>
                                  _loginData.password = value,
                                  onSaved: (value) =>
                                  _loginData.password = value,
                                  decoration: InputDecoration(
                                    //border: OutlineInputBorder(
                                    // borderRadius: BorderRadius.circular(5.0)),
                                    //labelText: 'E-mail',
                                    //border: InputBorder.none,
                                      hintText: '******'),
                                  obscureText: _obscureText,
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
                                    Icon(
                                      Icons.lock_open,
                                      color: Colors.black87,
                                      size: 19.0,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      'Senha',
                                      style: TextStyle(
                                          color: Colors.grey[500]),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20.0, top: 10.0),
                                child: TextFormField(
                                  key: _confirmPasswordKey,
                                  controller: _confirmPasswordController,
                                  validator: composeValidators('a senha', [
                                    requiredValidator,
                                    minLegthValidator
                                  ]),
                                  onChanged: (value) =>
                                  _loginData.confirmPassword = value,
                                  onSaved: (value) =>
                                  _loginData.confirmPassword = value,
                                  decoration: InputDecoration(
                                    //border: OutlineInputBorder(
                                    // borderRadius: BorderRadius.circular(5.0)),
                                    //labelText: 'E-mail',
                                    //border: InputBorder.none,
                                      hintText: '******'),
                                  obscureText: _obscureText,
                                ),
                              ),
                              SizedBox(height: 30.0),
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

                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a Snackbar.
                        final snackBar = new SnackBar(
                            content: new Text('Verifique a sua senha!'));
                        _scaffoldKey.currentState.showSnackBar(snackBar);
                        if (_passwordController.text !=
                            _confirmPasswordController.text) {
                          Text('Verifique a sua senha');
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DashboardScreen(user: user, token: token, sol: sol,)),
                          );
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => DashboardScreen(user: user, token: token, sol: sol,)),
                                  (Route<dynamic> route) => false);

                          print(Text(_passwordController.text));
                          print(Text(_confirmPasswordController.text));
                        }
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
                            Color(0xFF33691E),
                            Color(0xFF689F38),
                            Color(0xFF8BC34A),
                          ],
                        ),
                      ),
                      //padding: const EdgeInsets.fromLTRB(90.0, 15.0, 90.0, 15.0),
                      child: Center(
                          child:
                          const Text('SALVAR', style: TextStyle(fontSize: 20))),
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
