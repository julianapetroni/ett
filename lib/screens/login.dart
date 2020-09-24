import 'dart:convert';
import 'package:ett_app/screens/dasboardScreen.dart';
import 'package:ett_app/widgets/logoETT.dart';
import 'package:http/http.dart' as http;
import 'package:ett_app/services/token.dart';
import 'package:ett_app/style/lightColors.dart';
import 'package:flutter/material.dart';
import 'package:ett_app/domains/usuario.dart';
import 'package:ett_app/models/forms.dart';
import 'package:ett_app/screens/dadosCadastro.dart';
import 'package:ett_app/screens/esqueceuSenha.dart';
import 'package:ett_app/services/auth_api_service.dart';
import 'package:ett_app/utils/validators.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaLogin extends StatefulWidget {
  final AuthApiService authApi = AuthApiService();

  @override
  _TelaLoginState createState() => new _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  Usuario usuario;
  Token token;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _emailKey =
      GlobalKey<FormFieldState<String>>();

  LoginFormData _loginData = LoginFormData();
  bool _autovalidate = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void initState() {
    super.initState();
  }

  var heightLogoETT = 280.0;

  bool imagem = true;
  bool imagemComContainer = false;
  bool botaoLogin = true;
  MediaQueryData queryData;

  var imagemDoFundo;
  var extensaoDaImagemDoFundo;

  double loginWidth = 0.0;
  double loginHeight = 0.0;

  _makePostRequest(String user, String password) async {
    // set up POST request arguments
    String url =
        'https://app.cartaopec.com.br/api/uaa/oauth/token?username=$user&password=$password&grant_type=password';
    var body = null;

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
//      print("Response status: ${response.statusCode}");
//      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        Token token = Token.fromJson(map);
//        print(token.access_token);
        String url2 = 'https://app.cartaopec.com.br/api/v1/usuarios/userinfo';
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
                      DashboardScreen(user: usuario, token: token)));
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) =>
                      DashboardScreen(user: usuario, token: token)),
              (Route<dynamic> route) => false);
        });
      } else {
        final semCadastro =
            new SnackBar(content: new Text('Erro na autenticação!'));
        scaffoldKey.currentState.showSnackBar(semCadastro);
      }
    });
  }

  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    double imageHeight = queryData.size.height - 120;

    return Scaffold(
        key: scaffoldKey,
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
                    _imagemDoLogo(),
                    Visibility(
                      visible: botaoLogin,
                      child: Positioned(
                        bottom: 0,
                        child: new Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 500),
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
                                      imagemComContainer = true;
                                      botaoLogin = false;
                                    });
                                    showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        barrierColor: Colors.black.withAlpha(1),
                                        backgroundColor: Colors.transparent,
                                        builder: (BuildContext context) {
                                          return _bottomSheetLogin();
                                        });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
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
                                            builder: (context) =>
                                                DadosCadastro()),
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  _imagemDoLogo() {
    return Visibility(
      visible: imagemComContainer,
      child: LogoETT(heightLogoETT),
    );
  }

  _bottomSheetLogin() {
    return SingleChildScrollView(
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        child: Wrap(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Form(
                key: _formKey,
                autovalidate: _autovalidate,
                child: Container(
                    width: double.infinity,
                    height: 350,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(24.0),
                            topRight: const Radius.circular(24.0)),
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
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: TextFormField(
                              key: _emailKey,
                              //style: Theme.of(context).textTheme.headline,
                              controller: emailController,
                              validator: composeValidators('email', [
                                requiredValidator,
                                minLegthValidator,
                                emailValidator,
                              ]),

                              onSaved: (value) => _loginData.email = value,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.white),
                                  borderRadius: new BorderRadius.circular(25.0),
                                ),
                                prefixIcon: Icon(Icons.account_circle),
                                labelText: "E-mail",
                                filled: true,
                                fillColor: Colors.grey[200],
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: TextFormField(
                              key: _passwordKey,
                              controller: passwordController,
                              validator: composeValidators('senha',
                                  [requiredValidator, minLegthValidator]),
                              onSaved: (value) => _loginData.password = value,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.remove_red_eye),
                                  onPressed: _toggle,
                                ),
                                prefixIcon: Icon(Icons.lock),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.white),
                                  borderRadius: new BorderRadius.circular(25.0),
                                ),
                                labelText: "Senha",
                                filled: true,
                                fillColor: Colors.grey[200],
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                              obscureText: _obscureText,
                            ),
                          ),
                          SizedBox(height: 30.0),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                      fontSize: 14, color: Colors.black87),
                                )),
                              ),
                              Container(
                                height: 70,
                                alignment: Alignment.center,
                                //color: Colors.,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, left: 50, right: 50),
                                  child: Column(
                                    children: <Widget>[
                                      FlatButton(
                                        onPressed: () {
                                          // Validate returns true if the form is valid, or false
                                          // otherwise.
                                          if (_formKey.currentState
                                              .validate()) {
                                            _makePostRequest(
                                                emailController.text,
                                                passwordController.text);
                                            // _loginData.email, _loginData.password, scaffoldKey, emailController.text, passwordController.text);
                                            print(emailController.text
                                                .toString());
                                            print(passwordController.text
                                                .toString());
                                          }
                                        },
                                        textColor: Colors.white,
                                        //color: Colors.white,
                                        child: Container(
                                          width: double.infinity,
                                          height: 45.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                            gradient: LinearGradient(
                                              colors: <Color>[
                                                Colors.grey[400],
                                                Colors.grey[400],
                                                Colors.grey[400],
                                              ],
                                            ),
                                          ),
                                          child: Center(
                                              child: Row(
                                            children: <Widget>[
//                                                                Spacer(flex: 1),
//                                                                Icon(Icons.person),
                                              Spacer(flex: 3),
                                              Text(
                                                "ENTRAR",
                                                style: GoogleFonts.raleway(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    letterSpacing: 1),
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
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "CADASTRAR",
                                          style: GoogleFonts.raleway(
                                              fontSize: 15,
                                              color: Colors.black54),
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
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
