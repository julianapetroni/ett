import 'package:ett_app/screens/dasboardScreen.dart';
import 'package:ett_app/style/lightColors.dart';
import 'package:ett_app/testes/logintest.dart';
import 'package:flutter/material.dart';
import 'package:ett_app/domains/horaAgendamento.dart';
import 'package:ett_app/domains/usuario.dart';
import 'package:ett_app/models/forms.dart';
import 'package:ett_app/screens/dadosCadastro.dart';
import 'package:ett_app/screens/esqueceuSenha.dart';
import 'package:ett_app/style/sizeConfig.dart';
import 'package:ett_app/screens/status.dart';
import 'package:ett_app/services/auth_api_service.dart';
import 'package:ett_app/utils/validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/date_symbol_data_file.dart';
import 'package:ett_app/screens/status.dart';

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
  factory Token.fromJson(Map<String, dynamic> json) => Token(
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
  Usuario usuario;
  Token token;

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
        http.get(url2, headers: {
          'Authorization': 'bearer ' + token.access_token.toString()
        }).then((res) {
          Map<String, dynamic> map2 = jsonDecode(res.body);

          Usuario usuario = Usuario.fromJson(map2);

          print("ID: " + usuario.id.toString());
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DashboardScreen(user: usuario, token: token)),
//            MaterialPageRoute(builder: (context) => AgendarData()),
          );
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) =>
                      DashboardScreen(user: usuario, token: token)),
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
  bool _autovalidate = true;

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

  bool imagem = true;
  bool imagemComContainer = false;
  bool containerLogin = false;
  bool botaoLogin = true;
  bool botaoCadastrar = true;
  MediaQueryData queryData;

  var imagemDoFundo;
  var extensaoDaImagemDoFundo;

  double loginWidth = 0.0;
  double loginHeight = 0.0;

  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    SizeConfig().init(context);
    double imageHeight = queryData.size.height - 120;

    final inputBorder = BorderRadius.vertical(
      bottom: Radius.circular(10.0),
      top: Radius.circular(20.0),
    );

    SizeConfig().init(context);

    return ColorFiltered(
      colorFilter: ColorFilter.mode(
          LightColors.neonYellowLight.withOpacity(0), BlendMode.srcOver),
      child: Scaffold(
          //backgroundColor: LightColors.neonYellowLight,
          //Colors.grey[200],
          key: _scaffoldKey,
          body: SafeArea(
            bottom: false,
            top: false,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/YellowBus.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Visibility(
                        visible: imagemComContainer,
                        child: Container(
                          height: 280.0,
                          width: double.infinity,
                          //height: imageHeight,
                          child: Padding(
                            padding: const EdgeInsets.all(95.0),
                            child: Image(
                              image: AssetImage("images/logo-slim.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                      Visibility(
                        visible: botaoLogin,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 500),
                          child: Container(
                            width: queryData.size.width - 10,
                            height: 45.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              gradient: LinearGradient(
                                colors: <Color>[
                                  Colors.grey[700],
                                  Colors.grey[500],
                                  Colors.grey[200],
                                ],
                              ),
                            ),
                            child: FlatButton(
                              //color: Colors.grey[200],
                              child: Text('LOGIN',
                                  style: GoogleFonts.raleway(
                                      color: LightColors.neonETT,
                                      letterSpacing: 4,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20)),
                              onPressed: () {
                                setState(() {
                                  //imagem = false;
                                  imagemComContainer = true;
                                  containerLogin = true;
                                  botaoLogin = false;
                                  botaoCadastrar = false;
//                                loginWidth = 400.0;
//                                loginHeight = 300.0;
                                });
                              },
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      Visibility(
                        visible: botaoCadastrar,
                        child: Container(
                          width: queryData.size.width - 10,
                          height: 45.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            gradient: LinearGradient(
                              colors: <Color>[
                                Colors.grey[700],
                                Colors.grey[500],
                                Colors.grey[200],
                              ],
                            ),
                          ),
                          child: FlatButton(
                            onPressed: () {
                              setState(() {
                                imageHeight = 600.0;
                                loginWidth = 400.0;
                                loginHeight = 300.0;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DadosCadastro()),
                                );
                              });
                            },
                            child: Text(
                              'CADASTRAR',
                              style: GoogleFonts.raleway(
                                  color: Colors.red[800],
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20,
                                  letterSpacing: 4),
                            ),
                          ),
                        ),
                      ),
//                      Positioned(
//                        // top: 50,
//                          child: new Align(
//                            alignment: Alignment.bottomCenter,
//                            child: AnimatedContainer (
//                              duration: Duration (seconds: 1),
//                              width: loginWidth,
//                              height: loginHeight,
//                              color: Colors.red,
//                              //child: null,
//                            ),)
//                      ),
                    ],
                  ),
                  Visibility(
                    visible: containerLogin,
                    child: AnimatedContainer(
                      duration: Duration(seconds: 1),
//                              width: loginWidth,
//                              height: loginHeight,
                      child: Form(
                        key: _formKey,
                        autovalidate: _autovalidate,
                        child: Stack(children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.only(
//                                    left: 30.0,
//                                    right: 30.0,
                                      //top: 280.0,
                                      bottom: 0.0),
                                  child: Container(
                                      width: double.infinity,
                                      height: 350,
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.9),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
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
                                            left: 16.0, right: 16.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
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
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: new BorderSide(
                                                        color: Colors.white),
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(25.0),
                                                  ),
                                                  prefixIcon: Icon(
                                                      Icons.account_circle),
                                                  labelText: "E-mail",
                                                  filled: true,
                                                  fillColor: Colors.grey[200],
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                Colors.white),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 20.0),
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
                                                  suffixIcon: IconButton(
                                                    icon: Icon(
                                                        Icons.remove_red_eye),
                                                    onPressed: _toggle,
                                                  ),
                                                  prefixIcon: Icon(Icons.lock),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: new BorderSide(
                                                        color: Colors.white),
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(25.0),
                                                  ),
                                                  labelText: "Senha",
                                                  filled: true,
                                                  fillColor: Colors.grey[200],
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                Colors.white),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25.0),
                                                  ),
                                                ),
                                                obscureText: _obscureText,
                                              ),
                                            ),
                                            SizedBox(height: 30.0),
                                            Column(
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
                                                                //LoginTest()),
                                                        EsqueceuSenha()),
                                                      );
                                                    });
                                                  },
                                                  child: Container(
                                                      child: Text(
                                                    "Esqueceu a senha?",
                                                    style: GoogleFonts.raleway(
                                                        fontSize: 14,
                                                        color: Colors.black87),
                                                  )),
                                                ),
                                                Container(
                                                  height: 70,
                                                  alignment: Alignment.center,
                                                  //color: Colors.,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10,
                                                            bottom: 10,
                                                            left: 50,
                                                            right: 50),
                                                    child: Column(
                                                      children: <Widget>[
                                                        FlatButton(
                                                          onPressed: () {
                                                            // Validate returns true if the form is valid, or false
                                                            // otherwise.
                                                            if (_formKey
                                                                .currentState
                                                                .validate()) {
                                                              _makePostRequest(
                                                                  _emailController
                                                                      .text,
                                                                  _passwordController
                                                                      .text);

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

                                                              print(_emailController
                                                                  .text
                                                                  .toString());
                                                              print(_passwordController
                                                                  .text
                                                                  .toString());
                                                              //}
                                                              // _submit();
                                                            }
                                                          },
                                                          textColor:
                                                              Colors.white,
                                                          //color: Colors.white,
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            height: 45.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25.0),
                                                              gradient:
                                                                  LinearGradient(
                                                                colors: <Color>[
                                                                  Colors.grey[
                                                                      400],
                                                                  Colors.grey[
                                                                      400],
                                                                  Colors.grey[
                                                                      400],
                                                                ],
                                                              ),
                                                            ),
                                                            child: Center(
                                                                child: Row(
                                                              children: <
                                                                  Widget>[
//                                                                Spacer(flex: 1),
//                                                                Icon(Icons.person),
                                                                Spacer(flex: 3),
                                                                Text(
                                                                  "ENTRAR",
                                                                  style: GoogleFonts.raleway(
                                                                      fontSize:
                                                                          20,
                                                                      color: Colors
                                                                          .white,
                                                                      letterSpacing:
                                                                          1),
                                                                ),
                                                                Spacer(flex: 3),
                                                              ],
                                                            )),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 20,
                                                  alignment: Alignment.center,
                                                  //color: Colors.white,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  DadosCadastro()),
                                                        );
                                                      });
                                                    },
                                                    child: Container(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Text(
                                                            "CADASTRAR",
                                                            style: GoogleFonts
                                                                .raleway(
                                                                    fontSize:
                                                                        15,
                                                                    color: Colors
                                                                        .black54),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
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
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
