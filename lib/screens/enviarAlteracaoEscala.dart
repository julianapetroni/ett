import 'package:ett_app/domains/solicitacao.dart';
import 'package:ett_app/screens/dasboardScreen.dart';
import 'package:ett_app/style/lightColors.dart';
import 'package:ett_app/widgets/alertDialogForm.dart';
import 'package:ett_app/widgets/appBarNeon.dart';
import 'package:ett_app/widgets/backgroundDecoration.dart';
import 'package:ett_app/widgets/buttonDecoration.dart';
import 'package:ett_app/widgets/dropDownForm.dart';
import 'package:ett_app/widgets/inputForm.dart';
import 'package:ett_app/widgets/logoETTForm.dart';
import 'package:ett_app/widgets/subtitleForm.dart';
import 'package:ett_app/widgets/textRow.dart';
import 'package:ett_app/widgets/whiteFormDecoration.dart';
import 'package:flutter/material.dart';
import 'package:ett_app/models/forms.dart';
import 'package:ett_app/style/sizeConfig.dart';
import 'package:ett_app/utils/validators.dart';
import 'package:ett_app/domains/usuario.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ett_app/services/token.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

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

  EnviarAlteracaoEscalaState({this.user, this.token, this.sol});

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

  //Motivo
  String _dropdownError;

  _validateForm() {
    bool _isValid = _formKey.currentState.validate();

    if (_mySelection == null) {
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

  var heightLogoETT = 80.0;

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
      appBar: AppBarNeon(),
      body: BackgroundDecoration(
        SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  LogoETTForm(heightLogoETT),
                  Container(
                    padding: const EdgeInsets.only(top: 30.0),
                    width: double.infinity,
                    //margin: EdgeInsets.fromLTRB(0.0, 0.0, 40.0, 0.0),
                    child: Form(
                      key: _formKey,
                      autovalidate: _autovalidate,
                      child: WhiteFormDecoration(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextRow("Formulário de Alteração de Escala", Colors.black87),
                            SizedBox(
                              height: 40.0,
                            ),
                            SubtitleForm('Fora de serviço: *'),
                            InputForm(
                              _foraDeServicoKey,
                              dataController,
                              composeValidators('a data',
                                  [requiredValidator, dataValidator]),
                                  (value) => _loginData.foraDeServico = value,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            SubtitleForm('Veículo: *'),
                            InputForm(
                              _veiculoKey,
                              _veiculoController,
                              composeValidators('a placa',
                                  [requiredValidator, minLegthValidator]),
                                  (value) => _loginData.veiculo = value,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            SubtitleForm('Motivo: *'),
                            SizedBox(
                              height: 20.0,
                            ),
                            DropDownForm(
                                data.map((item) {
                                  return new DropdownMenuItem(
                                    child: new Text(item['item_name']),
                                    value: item['id'].toString(),
                                  );
                                }).toList(), (newVal) {
                              setState(() {
                                _mySelection = newVal;
                                _dropdownError = null;
                              });
                            }, _mySelection, true, 'Selecione o motivo',
                                _dropdownError),
                            SizedBox(
                              height: 20.0,
                            ),
                            SubtitleForm('Descrição:'),
                            InputForm(
                              _descricaoKey,
                              _descricaoController,
                              composeValidators('a descrição',
                                  [requiredValidator, minLegthValidator]),
                                  (value) => _loginData.descricao = value,
                            ),
                            SizedBox(height: 50.0),
                            FlatButton(
                              child: Padding(
                                padding:
                                const EdgeInsets.only(bottom: 20.0),
                                child: FlatButton(
                                  onPressed: () {
                                    _validateForm();
                                    if (_formKey.currentState
                                        .validate() &&
                                        _mySelection != null) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          // return object of type Dialog
                                          return AlertDialogForm(
                                              'Formulário registrado com sucesso!');
                                        },
                                      );
                                      Future.delayed(
                                          const Duration(
                                              milliseconds: 3000), () {
                                        //setState(() {

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DashboardScreen(
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
                                    } else {
                                      final semCadastro = new SnackBar(
                                          content: new Text(
                                              'Preencha todos os campos para prosseguir!'));
                                      _scaffoldKey.currentState
                                          .showSnackBar(semCadastro);
                                    }
                                  },
                                  textColor: Colors.white,
                                  color: Colors.white,
                                  child:  ButtonDecoration('ENVIAR'),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0),
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
