import 'package:flutter/material.dart';
import 'package:ett_app/domains/HoraAgendamento.dart';
import 'package:ett_app/domains/Usuario.dart';
import 'package:ett_app/models/forms.dart';
import 'package:ett_app/screens/dadosCadastro.dart';
import 'package:ett_app/screens/esqueceuSenha.dart';
import 'package:ett_app/style/sizeConfig.dart';
import 'package:ett_app/screens/status.dart';
import 'package:ett_app/services/auth_api_service.dart';
import 'package:ett_app/utils/validators.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/date_symbol_data_file.dart';

class TelaLogin extends StatefulWidget {
  final AuthApiService authApi = AuthApiService();

  @override
  _TelaLoginState createState() => new _TelaLoginState();
}

class Token {
  String access_token;
  String token_type;
  String refresh_token;
  String scope;
  Token({this.access_token, this.token_type, this.refresh_token, this.scope});
  factory Token.fromJson(Map<String, dynamic> json) =>
      Token(
        access_token: json['access_token'],
        token_type: json['token_type'],
        refresh_token: json['refresh_token'],
        scope: json['scope'],
      );
//  Map<String, dynamic> toJson() => {
//    "access_token": access_token,
//    "token_type": token_type,
//    "refresh_token": refresh_token,
//    "scope": scope,
//  };
}

class _TelaLoginState extends State<TelaLogin> {

  List<dynamic> _docs = [];

  _makePostRequest(String user, String password) async {
    // set up POST request arguments
    String url =
        'https://www.accio.com.br:447/api/uaa/oauth/token?username=$user&password=$password&grant_type=password';

//    String url =
//        'http://179.190.40.41:443/api/uaa/oauth/token?username=$user&password=$password&grant_type=password';
//    //Map<String, String> headers = {"Content-type": "application/json", "Authorization": "Basic YWV0dXItYXBwLWNsaWVudDphZXR1ci1hcHAtc2VjcmV0"};
    //String json = '{"title": "Hello", "body": "body text", "userId": 1}';
    // make POST request
    //Response response = await post(url, headers: headers, body: json);
    // check the status code for the result
//    var params = jsonEncode({
//      'username': '${user}',
//      'password': '${password}',
//      'grant_type': 'password'
//    });
    var body = null;
//    jsonEncode({ 'username': '${user}',
//      'password': '${password}',
//      'grant_type': 'password'
//    });

    http
        .post(url,
        headers: {
          'Content-Type':
          'application/x-www-form-urlencoded; charset=utf-8',
          'Authorization':
          'Basic YWV0dXItYXBwLWNsaWVudDphZXR1ci1hcHAtc2VjcmV0'
        },
        body: body)
        .then((http.Response response) {
      print("Response status: ${response.statusCode}");
      //print("Response body: ${response.contentLength}");
      //print(response.headers);
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        Token token = Token.fromJson(map);
        print(token.access_token);
        String url2 = 'https://www.accio.com.br:447/api/v1/usuarios/userinfo';
        http
            .get(url2,
            headers: {
              'Authorization':
              'bearer ' + token.access_token.toString()
            }).then((res) {

          Map<String, dynamic> map2 = jsonDecode(res.body);

          Usuario usuario = Usuario.fromJson(map2);

          print("ID: " + usuario.id.toString());
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Status(user: usuario, token: token)),
//            MaterialPageRoute(builder: (context) => AgendarData()),
          );
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Status(user: usuario, token : token)),
                  (Route<dynamic> route) => false);
        });
      } else {
        final semCadastro =
        new SnackBar(content: new Text('Erro na autenticação!'));
        _scaffoldKey.currentState.showSnackBar(semCadastro);
      }
    });
  }

  void _fetchDocs() {
    http
        .get(
        "https://www.accio.com.br:447/api/v1/usuarios/?access_token=b7060893-0678-4e51-95e8-9b4fecf91bb9")
        .then((res) {
      final docs = json.decode(res.body);

      setState(() {
        _docs = docs;
      });
    });
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordKey =
  GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _emailKey =
  GlobalKey<FormFieldState<String>>();

  LoginFormData _loginData = LoginFormData();
  bool _autovalidate = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  List<dynamic> _tipoSolicitacao = [];

  @override
  dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  _submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
//      widget.authApi.login(_loginData).then((data) {
//        print(data);
//      });
////      print(
////          'password is: ${_loginData.password}, email is: ${_loginData.email}');
    } else {
      setState(() => _autovalidate = true);
    }
  }

  // Initially password is obscure
  bool _obscureText = true;
  String _password;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void initState() {
    super.initState();
    //print('I am calling initState!');
    //_fechTipoSolicitacao();
    //_fetchDocs();
  }

  void _fechTipoSolicitacao() {
    http.get('https://jsonplaceholder.typicode.com/posts').then((res) {
      // print(res.body);
      Map<String, String> headers = {"Content-type": "application/json"};
      final tipoSolicitacao = json.decode(res.body);
      //print(tipoSolicitacao);
      setState(() {
        _tipoSolicitacao = tipoSolicitacao;
      });
    });
  }

  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: SafeArea(

        child: Scrollbar(

          child: CustomScrollView(

            slivers: <Widget>[

              SliverAppBar(
                //pinned: true,
                expandedHeight: SizeConfig.safeBlockVertical * 25,
                backgroundColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.zero,
                  centerTitle: true,

                  background: Image.asset("images/ETT.png", fit: BoxFit.contain),

                ),),

              SliverFixedExtentList(
                itemExtent: 380,
                delegate: SliverChildListDelegate([
                  Container(
                    color: Colors.white,
                    child: Form(
                      key: _formKey,
                      autovalidate: _autovalidate,
                      child: Stack(children: <Widget>[
                        Column(
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0,
                                    right: 25.0,
                                    top: 10.0,
                                    bottom: 20.0),
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
                                          left: 16.0, right: 16.0, top: 3.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
//                                          SizedBox(
//                                            height: 0.0,
//                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0, right: 20.0),
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.mail_outline,
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
                                              //style: Theme.of(context).textTheme.headline,
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
                                                  hintText: 'nome@email.com.br'),
                                            ),
                                          ),
                                          SizedBox(height: 20.0),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0, right: 20.0),
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.lock_open,
                                                  color: Colors.grey[400],
                                                  size: 17.0,
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
                                              validator: composeValidators(
                                                  'senha', [
                                                requiredValidator,
                                                minLegthValidator
                                              ]),
                                              onSaved: (value) =>
                                              _loginData.password = value,
                                              decoration: InputDecoration(
                                                  hintText: '******'),
                                              obscureText: _obscureText,
                                            ),
                                          ),
                                          SizedBox(height: 30.0),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              EsqueceuSenha()),
                                                    );
                                                  });
                                                },
                                                child: Container(
                                                    child: Text(
                                                      "Esqueceu a sua senha?",
                                                      style: TextStyle(
                                                          color: Colors.blue,
                                                          fontFamily:
                                                          "Poppins-Medium",
                                                          fontSize: 13.0),
                                                    )),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )))
                          ],
                        )
                      ]),
                    ),
                  ),
                ]),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    return Container(
                      height: 20,
                      alignment: Alignment.center,
                      color: Colors.white,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DadosCadastro()),
                            );
                          });
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Novo Usuário? ",
                                style: TextStyle(fontFamily: "Poppins-Medium"),
                              ),
                              Text("Cadastre-se",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontFamily: "Poppins-Bold")),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: 1,
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    return Container(
                      height: 70,
                      alignment: Alignment.center,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            FlatButton(
                              onPressed: () {
                                // Validate returns true if the form is valid, or false
                                // otherwise.
                                if (_formKey.currentState.validate()) {
                                  _makePostRequest(_emailController.text,
                                      _passwordController.text);

                                  // If the form is valid, display a Snackbar.
//                      Scaffold.of(context).showSnackBar(
//                          SnackBar(content: Text('Processing Data')));
//                      bool flag = false;
//                      for (int c = 0; c < _docs.length; c++) {
//                        print(c);
//                        if (_docs[c]['email'] == _emailController.text) {
//                          flag = true;
//                          if (_docs[c]['senha'] == _passwordController.text) {
//                            Navigator.push(
//                              context,
//                              MaterialPageRoute(builder: (context) => Status()),
//                            );
//                            Navigator.of(context).pushAndRemoveUntil(
//                                MaterialPageRoute(
//                                    builder: (context) => Status()),
//                                (Route<dynamic> route) => false);
//                          } else {
//                            final snackBar = new SnackBar(
//                                content:
//                                    new Text('E-mail ou senha incorretos'));
//                            _scaffoldKey.currentState.showSnackBar(snackBar);
//                            //print(_passwordController.text.toString());
//                          }
//                        }
//                      }
//                      if (flag == false) {
//                        final semCadastro = new SnackBar(
//                            content: new Text('Usuário não cadastrado!'));
//                        _scaffoldKey.currentState.showSnackBar(semCadastro);
//                      }

                                  print(_emailController.text.toString());
                                  print(_passwordController.text.toString());
                                  //}
                                  // _submit();
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
                                    child: Row(
                                      children: <Widget>[
                                        Spacer(flex: 1),
                                        Icon(Icons.person),
                                        Spacer(flex: 2),
                                        const Text('ENTRAR',
                                            style: TextStyle(fontSize: 20)),
                                        Spacer(flex: 3),
                                      ],
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: 1,
                ),
              ),
//            SliverList(
//              delegate: SliverChildBuilderDelegate(
//                (context, index) {
//                  return Container(
//                    height: 10,
//                    alignment: Alignment.center,
//                    color: Colors.white,
//                    child: GestureDetector(
//                      onTap: () {
//                        setState(() {
//                          Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                                builder: (context) => DadosCadastro()),
//                          );
//                        });
//                      },
//                      child: Container(
//                        child: Text(' '),
//                      ),
//                    ),
//                  );
//                },
//                childCount: 1,
//              ),
//            ),
            ],
          ),
        ),
      ),
    );
  }
}
