import 'dart:convert';
import 'package:ett_app/screens/dashboard/ui/dasboard.page.dart';
import 'package:ett_app/screens/login/ui/login.strings.dart';
import 'package:ett_app/services/auth.strings.dart';
import 'package:ett_app/widgets/formUI/button/button_decoration.dart';
import 'package:ett_app/widgets/formUI/input/input_form_with_decoration.dart';
import 'package:http/http.dart' as http;
import 'package:ett_app/services/token.dart';
import 'package:ett_app/generalConfig/generalConfig.strings.dart';
import 'package:flutter/material.dart';
import 'package:ett_app/domains/usuario.dart';
import 'package:ett_app/models/forms.dart';
import 'package:ett_app/services/auth_api_service.dart';
import 'package:ett_app/utils/validators.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaLogin extends StatefulWidget {
  final AuthApiService authApi = AuthApiService();

  @override
  _TelaLoginState createState() => new _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin>
    with SingleTickerProviderStateMixin {
  Usuario usuario;
  Token token;
  FocusNode inputFieldNode;

  MediaQueryData queryData;
  var heightLogoETT = 90.0;

  ///loading
  bool _load = false;

  /// Animation
  AnimationController controller;
  Animation animation;

  /// Initially password is obscure
  bool _obscureText = true;
  bool _autovalidate = false;

  LoginFormData _loginData = LoginFormData();

  /// Controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _emailKey =
      GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);

    return Scaffold(
        key: scaffoldKey,
        body: Stack(
          children: [
            _buildLogo(context),
            _buildBottomSheet(context),
          ],
        ));
  }

  Widget _buildLogo(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/YellowBus.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(95.0),
            child: Image(
              image: AssetImage(GeneralConfig.logoImage),
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: SingleChildScrollView(
            child: Container(
              height: animation.value * 315,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.0),
                      topRight: Radius.circular(24.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 15.0),
                        blurRadius: 15.0),
                    BoxShadow(
                      color: Color.fromRGBO(34, 34, 34, 0.12),
                      spreadRadius: 0,
                      blurRadius: 8,
                      offset: Offset(0, 0),
                    ),
                  ]),
              child: Form(
                key: _formKey,
                autovalidate: _autovalidate,
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InputFormWithDecoration(
                          paddingTop: 40.0,
                          labelTextForm: LoginStrings.login,
                          prefixIcon: Icon(Icons.account_circle),
                          keyForm: _emailKey,
                          controller: _emailController,
                          keyboardType: TextInputType.number,
                          validatorForm: composeValidators('chapa', [
                            requiredValidator,
                            minLengthValidator,
                            // maxLengthNumero6Validator,
                            // numberValidator,
                          ]),
                          onSavedForm: (value) => _loginData.email = value,
                          larguraInputForm: double.infinity,
                          focusNode: inputFieldNode,
                          obscureText: false,
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //       top: 40, left: 20.0, right: 20.0),
                        //   child: TextFormField(
                        //     key: _emailKey,
                        //     focusNode: inputFieldNode,
                        //     controller: _emailController,
                        //     keyboardType: TextInputType.number,
                        //     validator: composeValidators('chapa', [
                        //       requiredValidator,
                        //       minLengthValidator,
                        //       // maxLengthNumero6Validator,
                        //       // numberValidator,
                        //     ]),
                        //     onSaved: (value) => _loginData.email = value,
                        //     decoration: InputDecoration(
                        //       enabledBorder: UnderlineInputBorder(
                        //         borderSide: new BorderSide(color: Colors.white),
                        //         borderRadius: new BorderRadius.circular(25.0),
                        //       ),
                        //       prefixIcon: Icon(Icons.account_circle),
                        //       labelText: LoginStrings.login,
                        //       filled: true,
                        //       fillColor: Colors.grey[200],
                        //       focusedBorder: OutlineInputBorder(
                        //         borderSide:
                        //             const BorderSide(color: Colors.white),
                        //         borderRadius: BorderRadius.circular(25.0),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(height: 20.0),

                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: TextFormField(
                            key: _passwordKey,
                            controller: _passwordController,
                            keyboardType: TextInputType.number,
                            validator: composeValidators('senha', [
                              requiredValidator,
                              // minLengthPwdValidator,
                              // maxLengthCEPValidator,
                              // numberPswValidator,
                            ]),
                            onSaved: (value) => _loginData.password = value,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: _toggle,
                              ),
                              prefixIcon: Icon(Icons.lock),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white),
                                borderRadius: new BorderRadius.circular(25.0),
                              ),
                              labelText: LoginStrings.loginPassword,
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
                            ButtonDecoration(
                              buttonTitle: LoginStrings.buttonTitle,
                              shouldHaveIcon: false,
                              onPressed: () {
                                // Validate returns true if the form is valid, or false
                                // otherwise.
                                final form = _formKey.currentState;
                                if (form.validate()) {
                                  form.save();

                                  _makePostRequest(_emailController.text,
                                      _passwordController.text);

                                  // print(
                                  //     _emailController.text.toString());
                                  // print(_passwordController.text
                                  //     .toString());
                                } else {}

                                setState(() {
                                  _autovalidate = true;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void initState() {
    super.initState();

    inputFieldNode = FocusNode();

    /// Animation
    controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    controller.dispose();
    inputFieldNode.dispose();

    super.dispose();
  }

  _makePostRequest(String user, String password) async {
    setState(() {
      ///loading
      _load = true;
    });

    String url = AuthStrings.baseUrl +
        'uaa/oauth/token?username=$user&password=$password&grant_type=password';
    var body;

    http
        .post(url,
            headers: {
              'Content-Type':
                  'application/x-www-form-urlencoded; charset=utf-8',
              'Authorization':
                  'Basic YWV0dXItYXBwLWNsaWVudDphZXR1ci1hcHAtc2VjcmV0'
            },
            body: body)
        .then((http.Response response) async {
      print("Response status: ${response.statusCode}");
      print(response.body);
      setState(() {
        ///loading
        _load = true;
      });

      if (response.statusCode == 200) {
        setState(() {
          ///loading
          _load = false;
        });
        Map<String, dynamic> map = jsonDecode(response.body);
        Token token = Token.fromJson(map);
        print(token.access_token);
        String url2 = AuthStrings.baseUrl + AuthStrings.userInfo;
        await http.get(url2, headers: {
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
          );
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) =>
                      DashboardScreen(user: usuario, token: token)),
              (Route<dynamic> route) => false);
        });
      } else {
        setState(() {
          ///loading
          _load = false;
        });
        scaffoldKey.currentState.showSnackBar(
            new SnackBar(content: new Text(LoginStrings.loginError)));
      }
    }).catchError((e) {
      setState(() {
        ///loading
        _load = false;
      });
      scaffoldKey.currentState.showSnackBar(
          new SnackBar(content: new Text(LoginStrings.loginOtherError)));
    });
  }
}
